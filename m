Return-Path: <kernel-hardening-return-12638-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtxVhDzcz7kpPeiPlOecwTLNgHjt3Lxvgi/+P+truZsvGPzTxW33kN+wQJej5TTtZzzjZHR
ARC-Seal: i=1; a=rsa-sha256; t=1521139905; cv=none;
        d=google.com; s=arc-20160816;
        b=UvlnbmXE2WRVgYH6lmNLMIi4DA7ZwYZ5XgSh7sYKA2/gB4fDgWiuKw4r+L/CjMEncC
         Rqsc2MhjZtvH8twBN+nYJ9dLfZfqXRK/+OJjx5IXxnt31oi9PBFk7CqBHT62RHM5LzQw
         6yPL2iBhK/1YcWaLyif70EMtJGXZM+Hjh9ppWLWF1mUQ8yOMQC0v6/JbammB+HeAqhmu
         za7Ro92mXuYAMk22Ytg/H45Clep0L8ngAdRodikKZ9j6tAxVrPEaFdeYwAfYfksjd4w6
         Kcwmtz1KvcbPVs99ivayuqa0rDz9UpGjOgkQvlsJhxj8oUlFImktD1IHPeIYS0+uW8QB
         JmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=zDTRq/Kbi8opxj3BIkb/QKU37raP/Uan08Eg4CDki/k=;
        b=nro3nPiXq/3QiZBulcf176EG2I/OhpLBcXcEDVr9sQ8ZfIJxmZmgKdT7Fjt8KEm/kQ
         twM488t8tMDVw4sU8ZxGZkFF6UQQdnsPqML9otNkl3NkSUkjLVCJFV2PTdlzckJ8wnj3
         E5AIU9getKEgLRb1DawgEF9uSv+vDfP6WE+qT6jEySHVLa3ZRmIYVbEnfCf4dlKMbsNn
         UEDwm5z4X4ZgEpMAAmxAgyaXaZFUqG9N5hRtthqWSIa5E/3R1K5WBlZ+S5W6fBXitv6I
         0GOl1J6Sq7KaPERbmN/yZrBe3w4EVoB1l78wIs/aqWE3mBRi9xC7Bcp8cCu0z35tHQPh
         UmEw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XQh67KDI;
       spf=pass (google.com: domain of kernel-hardening-return-12638-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12638-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XQh67KDI;
       spf=pass (google.com: domain of kernel-hardening-return-12638-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12638-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 4/8] struct page: add field for vm_struct
To: Igor Stoppa <igor.stoppa@huawei.com>, Matthew Wilcox <willy@infradead.org>
Cc: david@fromorbit.com, rppt@linux.vnet.ibm.com, keescook@chromium.org,
 mhocko@kernel.org, labbott@redhat.com,
 linux-security-module@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
 <20180313214554.28521-5-igor.stoppa@huawei.com>
 <20180313220040.GA15791@bombadil.infradead.org>
 <7b18521c-539b-2ba1-823e-e83be071c13f@gmail.com>
 <6924c919-dbfb-a9f6-748a-0bbfe8d876b1@huawei.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <007b20f7-54f8-0397-88ce-4a106bfdb8e9@gmail.com>
Date: Thu, 15 Mar 2018 11:51:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6924c919-dbfb-a9f6-748a-0bbfe8d876b1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594860882497845479?=
X-GMAIL-MSGID: =?utf-8?q?1595030797374874814?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/15/18 2:38 AM, Igor Stoppa wrote:
> On 14/03/18 19:43, J Freyensee wrote:
>> On 3/13/18 3:00 PM, Matthew Wilcox wrote:
> [...]
>
>>>> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
>>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>> Igor, do you mind sticking these tags on the files that have spent some
>> time reviewing a revision of your patchset (like the Reviewed-by: tags I
>> provided last revision?)
> Apologies, that was not intentional, I forgot it.
> I will do it, although most of the files will now change so much that I
> am not sure what will survive, beside this patch, in the form that you
> reviewed.
>
> I suppose the Review-by tag drops, if the patch changes.

That's true, if so much of the patch changes it basically looks like 
something different, the Reviewed-by: would drop.

Jay

>
> --
> igor
