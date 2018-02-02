Return-Path: <kernel-hardening-return-11557-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224W/BTAsXQmIB74k5yr6KelEg9jFTd9KfDPjFCrLB0gpuAuBB8H/Oc2M/HN+KxyNiOpC8/P
ARC-Seal: i=1; a=rsa-sha256; t=1517589990; cv=none;
        d=google.com; s=arc-20160816;
        b=peXR6YhWk9r+ZwBNUixv/M18yWenAGEW4hcq8nTRrwmEDaBJEU96SgyNCNkTWcHyrd
         cXBLIfQMEoyAUOOPW+jU8a/BKffxrdaeUcDujPc32gGf6uzzgSiY4MllOkgHbHReZQiD
         B5c3jGhXE+OgjwIoniBavE7/g+qCjdi1A8GceT3aKsv0dhEIoHsDrmfpIShWTh1kMG1c
         E8BXvLIsWoDfyZ7HigcIo0+d0Y/iOk71KJJX7umSGoreHX3BsMqkCxoL/dKezEO+rZCs
         xF7TVRflyy95qAS8JwaC1c2EHjRJXdU9JBDqrtrsJ2xMY7koB5FJW8+6deLve33wCMCF
         mVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=iwQQUfTj8nFon1vZkAmIne151CjlR69D69LYIrEghHE=;
        b=WY0uEU4qF+02ioHCDHuuJqsZUD9AiKguL4LyGjWhlunlvmsooscfU+/fQ+NtHTXBCZ
         ftMxix4YqJufAL5412uRLnFGqDk2dg2NkI0VR6Mu8db9x14jfE+tP3SY7Lr0Ytzno6HX
         jIltZ2O8BcekBMEsXMNfvePVnLN64Dzz2+sFxc56JLbyHktmErTNEj7IQUQZfxfMcee/
         NXV58/Bu+giFa38gupMAyAP+Uek0DsUtcqSgWE/4vIv3MFyUJi025Ta0bXj24buUqkas
         x18lM15tWbIH8L4DtmZWBETJ0r0rsHi1fX+DEk6oI7bvcN/kuf02xN41EcWkbvA7rQ2z
         shOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11557-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11557-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11557-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11557-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 3/6] struct page: add field for vm_struct
To: Kees Cook <keescook@chromium.org>
CC: Christopher Lameter <cl@linux.com>, <jglisse@redhat.com>, Michal Hocko
	<mhocko@kernel.org>, Laura Abbott <labbott@redhat.com>, Christoph Hellwig
	<hch@infradead.org>, Matthew Wilcox <willy@infradead.org>,
	linux-security-module <linux-security-module@vger.kernel.org>, Linux-MM
	<linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>
References: <20180130151446.24698-1-igor.stoppa@huawei.com>
 <20180130151446.24698-4-igor.stoppa@huawei.com>
 <alpine.DEB.2.20.1801311758340.21272@nuc-kabylake>
 <48fde114-d063-cfbf-e1b6-262411fcd963@huawei.com>
 <CAGXu5jKKeJL13dcaY=fDJ8AiOXDP5MhQTqDYDOt3a374CFA1HQ@mail.gmail.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <938d71a3-323a-1af3-3815-cd5e1b9813c9@huawei.com>
Date: Fri, 2 Feb 2018 18:01:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKKeJL13dcaY=fDJ8AiOXDP5MhQTqDYDOt3a374CFA1HQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591031026595146297?=
X-GMAIL-MSGID: =?utf-8?q?1591308441969712804?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 01/02/18 23:11, Kees Cook wrote:

> IIUC, he means PageHead(), which is also hard to grep for, since it is
> a constructed name, via Page##uname in include/linux/page-flags.h:
> 
> __PAGEFLAG(Head, head, PF_ANY) CLEARPAGEFLAG(Head, head, PF_ANY)

Thank you, I'll try to provide a meaningful reply soon, but I'll be AFK
during most of next 2 weeks, so it might be delayed :-(

--
igor
