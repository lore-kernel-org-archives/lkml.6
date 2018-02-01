Return-Path: <kernel-hardening-return-11552-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x2269OvxGVSEGwGRu2eEctcp3M1/V1T/oMv9MN/4MyHkpMgmHN80PKlXPCWnPaKmCU2oh7+Cj
ARC-Seal: i=1; a=rsa-sha256; t=1517519495; cv=none;
        d=google.com; s=arc-20160816;
        b=Ay7MUX7uYVC6FSFNLj+PodMWrV4xHX4K9asO3vkhFaGa3zdXwKV2Ep2+i1oUcbq9wd
         ugUoyQxtLaEyh2U5qkuDodrTphIrPBBBTXA9ovHNFSHPIEkrpbnntQPP8bzUFwUWrnts
         vXOYO1NBYjzQPc9nD+q3z2/US2CWtvIrv09UFElcUwEMNUGZNtDgM6FY2vy//PZsilbY
         VNXJuJL0NlAQaNNZWzlDO3FRrYd10zJw6hUW6/LFW6/HTNm1wpsW7zwsvwQIf9MW/llA
         jOaejznIUAOd039LZ39Pf2jxn+dAmDsIEGIbQxtcEDB6f4l1Ca7ArSD+Xmhaxex9UnK/
         scjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=iqKnD2YMHWWbFdxY2WBdCg6YK65Wa5Dvtq30YWjJLrw=;
        b=DWADALEHY3wI94k8a96Z5RoVPt9ZsHgc3FdNOvCTgUXdnaiMHqMpT2asPgY14EVj9+
         VLN+Mquykq/d/7fGU9Kc+Mk7nepyzv77HAB1VAFTA50mnfV0wx5AGap5hzW22F78924o
         6T4VOffX276R9hgC67IX9jFWWeeKACmdKvS8oqvbs3WABNjI+E7+cQ/BH7QkdrcC0dD5
         bMZgyX3SchJEdcMgjLHTYQ8FrbI/51CIP5Xx0kWMx8Pkjygac8aHr4MIMIsA9PVtxbcq
         3Ztrp6vKgqx0EmHmgNL8gT27rKuFBgd/9gzsjMoPQ2KIqxgFPkT+QNgMWTkcOsRTD4Qo
         B4eg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=V2v9IDvP;
       dkim=pass header.i=@chromium.org header.s=google header.b=eH+ojwso;
       spf=pass (google.com: domain of kernel-hardening-return-11552-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11552-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=V2v9IDvP;
       dkim=pass header.i=@chromium.org header.s=google header.b=eH+ojwso;
       spf=pass (google.com: domain of kernel-hardening-return-11552-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11552-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <48fde114-d063-cfbf-e1b6-262411fcd963@huawei.com>
References: <20180130151446.24698-1-igor.stoppa@huawei.com>
 <20180130151446.24698-4-igor.stoppa@huawei.com> <alpine.DEB.2.20.1801311758340.21272@nuc-kabylake>
 <48fde114-d063-cfbf-e1b6-262411fcd963@huawei.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 2 Feb 2018 08:11:15 +1100
X-Google-Sender-Auth: MsBhN3-9z2ILzoErtCRGS5ymKnw
Message-ID: <CAGXu5jKKeJL13dcaY=fDJ8AiOXDP5MhQTqDYDOt3a374CFA1HQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] struct page: add field for vm_struct
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Christopher Lameter <cl@linux.com>, jglisse@redhat.com, Michal Hocko <mhocko@kernel.org>,
	Laura Abbott <labbott@redhat.com>, Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-security-module <linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>, kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591031026595146297?=
X-GMAIL-MSGID: =?utf-8?q?1591234522415202101?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 1, 2018 at 11:42 PM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
> On 01/02/18 02:00, Christopher Lameter wrote:
>> Would it not be better to use compound page allocations here?
>> page_head(whatever) gets you the head page where you can store all sorts
>> of information about the chunk of memory.
>
> Can you please point me to this function/macro? I don't seem to be able
> to find it, at least not in 4.15

IIUC, he means PageHead(), which is also hard to grep for, since it is
a constructed name, via Page##uname in include/linux/page-flags.h:

__PAGEFLAG(Head, head, PF_ANY) CLEARPAGEFLAG(Head, head, PF_ANY)

-Kees

-- 
Kees Cook
Pixel Security
