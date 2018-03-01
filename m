Return-Path: <boris.ostrovsky@oracle.com>
X-Google-Smtp-Source: AG47ELtC2bObOkkVdwFm47aehRkF4F8UjIbfH3VCq8VdhyxSMbLmagxYVB5lioGFwr/IYUHOQT7h
ARC-Seal: i=1; a=rsa-sha256; t=1519916877; cv=none;
        d=google.com; s=arc-20160816;
        b=mX3paXk9pn6/LxB2szexwdT8bpQ6BqXpaqwhPHgJ11AbnGFasR2mnI2uP+M71BsYUa
         ri+Oz11UijtM8nthqHbD4i7IXJFWBdpyBEDtIJX6EAY0EpLTv0uwasC9VAzLy3TginG0
         XeNVys963JJlt5rmzSZTjF18jGKadUUICwihaOZjVsSOpEKWXHhydpzugn5pLU328h34
         qvG0KtDCh7zI10onHVLXjxHnlFynd0h/yVcEgn/SvbUumgSuXVf5XwsR0xIxMM9HxQtb
         hF46EZeTtjQL90BlGIJ08BUgGUKmamr2vaSx5rEc6Tt7JZ/TK7wJ4ccItaB7lWJvYNCn
         l8AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=HJ9ts2R+50NAj722dkQJSBclf2nY/C6qYku7AxGcvBY=;
        b=l7G9QR7zNy+aK+dhkMHiJHKXgMYLFwAhE3zyAdwkY5Qr8vHI6IFBoHakN1D5iy474P
         djwsvcDsPN6VBPiRawGoRKVhFzFfgF8ejv8lOh7F36a9yBGaokzQo9oCn8D/BKiryT2H
         n3HhvLpijNCMsjVDWDMkquT682B5nLBJruWeR2HETKF9j6TjbIx6z3Gejgav2tpqB0WQ
         SyH8VgoJIIQfBbGFU+hyYn3CwmSpdenxszeATXKkk3svhGl7eMq0rnERFuuqQp8qCpXS
         yedto0DlPWRqMhrV2kFioaxm0AgT+QTPw7+oemC+LUUiqjrGgCk6El7go1FpPvCcIJxZ
         HSuw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=bM9ilyER;
       spf=pass (google.com: domain of boris.ostrovsky@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=boris.ostrovsky@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=bM9ilyER;
       spf=pass (google.com: domain of boris.ostrovsky@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=boris.ostrovsky@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [RFC PATCH v4 1/7] xen/pvh: Split CONFIG_XEN_PVH into CONFIG_PVH
 and CONFIG_XEN_PVH
To: Maran Wilson <maran.wilson@oracle.com>, pbonzini@redhat.com,
        jgross@suse.com, roger.pau@citrix.com, andrew.cooper3@citrix.com,
        hch@infradead.org, JBeulich@suse.com, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rkrcmar@redhat.com,
        jpoimboe@redhat.com, bp@suse.de, kirill.shutemov@linux.intel.com,
        thomas.lendacky@amd.com, luto@kernel.org, dave.hansen@linux.intel.com,
        davem@davemloft.net, gregkh@linuxfoundation.org, mchehab@kernel.org,
        linus.walleij@linaro.org, rdunlap@infradead.org
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
 <1519842483-8887-2-git-send-email-maran.wilson@oracle.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <5be04d96-aa10-a022-2597-f7f40138f8f8@oracle.com>
Date: Thu, 1 Mar 2018 10:02:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519842483-8887-2-git-send-email-maran.wilson@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8818 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=946
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803010190
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670432609567761?=
X-GMAIL-MSGID: =?utf-8?q?1593748360480503205?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/28/2018 01:27 PM, Maran Wilson wrote:
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index eb7f43f23521..fa7cd0305125 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -791,6 +791,14 @@ config KVM_GUEST
>  	  underlying device model, the host provides the guest with
>  	  timing infrastructure such as time of day, and system time
>  
> +config PVH
> +	bool "Support for running PVH guests"
> +	depends on KVM_GUEST || XEN


Not sure about XEN part. PVH is selected by XEN_PVH for Xen.

What about introducing KVM_GUEST_PVH that will select PVH and then drop
dependency here?


-boris

> +	def_bool n
> +	---help---
> +	  This option enables the PVH entry point for guest virtual machines
> +	  as specified in the x86/HVM direct boot ABI.
> +
>  


> diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
> index f605825a04ab..021c8591c3c0 100644
> --- a/arch/x86/xen/Kconfig
> +++ b/arch/x86/xen/Kconfig
> @@ -77,8 +77,9 @@ config XEN_DEBUG_FS
>  	  Enabling this option may incur a significant performance overhead.
>  
>  config XEN_PVH
> -	bool "Support for running as a PVH guest"
> +	bool "Support for running as a Xen PVH guest"
>  	depends on XEN && XEN_PVHVM && ACPI
>  	# Pre-built page tables are not ready to handle 5-level paging.
>  	depends on !X86_5LEVEL
> +	select PVH
>  	def_bool n
