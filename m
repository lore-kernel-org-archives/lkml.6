Return-Path: <kernel-hardening-return-12113-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvV0C17tXOHHWX0KafrxQqh3gwr+1GPW4/CS1f1VdLRPyK2QRfrcjZINC8MlKztgNwtrATS
ARC-Seal: i=1; a=rsa-sha256; t=1520278655; cv=none;
        d=google.com; s=arc-20160816;
        b=Tuq3knUI/QYdSp129bFcEWyftoT8yFaWjMGeY0deEEcDz/xx0mTwoc065iwU7W6KLP
         8ISocqTMRMAlqeEZr42bNu+Ii8FBuUQZ84S+3SGTVRG1iNkCNWCxhgdfe3Yd4F7gogrI
         AWmpRN+1mdi/HmEuRPTqlj+8z5B7w+7aav85s3CwZUM0TDA0kdq5GnYfd+Gx3+54APN0
         vWYAEyn/dioYdm1fPEerzFDSTvENVRLMeeEC7fEBGQJB9Rvv3rWspE77JcgZtYH6ppIi
         287WCmDUEE69T06YJ+0HaCm+vJeBCmYbXKe5c04ysLLru9ZUUFTbt4ikVf7lm6H7GBlY
         dRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=ThwfKO81QuMtjgWN1sWYamzrMf8K6daY3gHs6Pk6uAw=;
        b=yadt/hmpK5LjqQHepKMeLh6O2yDgSV6MxTQeDHhVPZDZSNop9w2ZBVEVcvtb2/BPds
         XJdZ8cIjZ3m1JqE35iINi+s4j9yf9szu9zWFOdQQ4qJBtYOAsBOeTcJ5sjOuHJlhB8ns
         1yyMZD2Bagd1DuGYeM/6GDr0Ett9XDodrQmES2hcN3+4U42F+CkXE2H76ZeP5t9KmBlB
         xIwpQoFzTiUWCW5msbtjZRHUBv8NPL13QB0jVs8JL2r4ed9M8uWeT1vXQphPgwHVKJcy
         y1gB3tATm90NOd6hUFvLh2b83b+S6yAoYCBsGT6mG1oowqLig6A3V38CqHnn/9bMooWj
         AB9A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bN8NbwtI;
       spf=pass (google.com: domain of kernel-hardening-return-12113-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12113-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bN8NbwtI;
       spf=pass (google.com: domain of kernel-hardening-return-12113-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12113-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 2/7] genalloc: selftest
To: Igor Stoppa <igor.stoppa@huawei.com>, david@fromorbit.com,
 willy@infradead.org, keescook@chromium.org, mhocko@kernel.org
Cc: labbott@redhat.com, linux-security-module@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
References: <20180228200620.30026-1-igor.stoppa@huawei.com>
 <20180228200620.30026-3-igor.stoppa@huawei.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <488cc366-bd10-425c-ef62-ce8536e3c62a@gmail.com>
Date: Mon, 5 Mar 2018 11:37:10 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228200620.30026-3-igor.stoppa@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676628857384150?=
X-GMAIL-MSGID: =?utf-8?q?1594127711154971979?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> +
> +/*
> + * In case of failure of any of these tests, memory corruption is almost
> + * guarranteed; allowing the boot to continue means risking to corrupt
> + * also any filesystem/block device accessed write mode.
> + * Therefore, BUG_ON() is used, when testing.
> + */
> +
> +

I like the explanation; good background info on why something is 
implemented the way it is :-).

Reviewed-by: Jay Freyensee <why2jjj.linux@gmail.com>
