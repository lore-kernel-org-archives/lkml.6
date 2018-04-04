Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3758820-1522829799-2-7220232223052416099
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522829798; b=vHBu3d/l5Mt8pBL648GQF2z8xCJSxaxwxflOxUZUKI5zdaDETJ
    DMRhmdWE+LakXwP0PtimFmlWNl8YTYJls4+hLjikHiiNJ6Ogr1FXNz51La6BjxVl
    nPNYWkFH1quap74/WkxzgdFZrOtob8ZPY0yRyrrQ6KJZgMbz+tYNW3Gz05joMGLj
    YQx6qemB4bmf4MgNLQVsKE/umTbj5SS61NlukRVjJxOdKRjbCjLWNhHUCYURcnGF
    z3KTu+WadJAxi0DZCwiV5RXlL/UyHtbfb9tyVmbuwK+AuGoR+VxF5Xu7g7zm9JpX
    8vQN5XT9JnPAvKFTK4xTd4+PwYtfBUvwCryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522829798; bh=CtGfY
    VKy9S1mNF6X3jBN7oWZNQMeNVO/PeLvo0fOFqQ=; b=FRQuBHzU1H83IofctOIZR
    kM23QmFXU3U7YjkXbPgpS2VwwdikUX3KAItZ5Ctdd6spro28bFaOVKpqa/A0jJdC
    HBYxg72AjRXrZ/8goI2m7GrQCAG2ogT+0xzkhEsYQuGRGH68uVu70Dkf8Rkk2Da1
    bkbywsYzKE8Afzfh9Z3/I7oAs2wV3rBIVpCnqwqps8pVZzWa5cX6ru6HGaJJNnKQ
    mMoA0s8c0JI4YXpybb1TfwAIePvNDjrlyDQqkITbJ8y0bxtYhzbrKd1FFDb7G1Mw
    JnBS0nyz0QTx/EhK3xPw+yPhTyzZb3LTwCqJARWmu7y4uZwZa7r17fVf0fZ0+xCY
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFu0RCQkd+Me9E/Pg3Iyp/H0FkIhXpe6+b9Qxk8Oyt6omL+kYXFPh9zETQ5RPPqENs96h5ULAhN8hOem8xiWeLAOnDxuU2HpK+ho3XNkbQ94hIenQnOQ
    7jPIoGvwkrjAYb16V8VnySkiGGGQeEIRgws8pIvtnviYTOstN40NaA4j2VR+KuS8iCFSGWIoAzRMukFQb9C4aqiy4q9U2aOLB1zlFt1qNOSyi0JcIi56baEe
    loH+w0/FCZHSrsRc3scAJg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=RH1W-9reD_IvN4SDLEYA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 4 Apr 2018 10:16:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: mikelley@microsoft.com
Subject: Re: [PATCH v2 char-misc 1/1] x86/hyperv: Add interrupt handler
 annotations
Message-ID: <20180404081629.GA22277@kroah.com>
References: <1522789148-1787-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1522789148-1787-1-git-send-email-mikelley@microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: olaf@aepfle.de, sthemmin@microsoft.com, jasowang@redhat.com,
 linux-kernel@vger.kernel.org, marcelo.cerri@canonical.com, apw@canonical.com,
 devel@linuxdriverproject.org, vkuznets@redhat.com,
 leann.ogasawara@canonical.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 01:59:08PM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mikelley@microsoft.com>
> 
> Add standard interrupt handler annotations to
> hyperv_vector_handler().
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
> Changes in v2:
> * Fixed From: line
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 4488cf0..20f6849 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -41,7 +41,7 @@ static void (*hv_stimer0_handler)(void);
>  static void (*hv_kexec_handler)(void);
>  static void (*hv_crash_handler)(struct pt_regs *regs);
>  
> -void hyperv_vector_handler(struct pt_regs *regs)
> +__visible void __irq_entry hyperv_vector_handler(struct pt_regs *regs)

What bug does this solve?  What is wrong with the existing markings?
What does __visible and __irq_entry give us that we don't already have
and we need?

Are you really using LTO that requires this marking to prevent the code
from being removed?

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
