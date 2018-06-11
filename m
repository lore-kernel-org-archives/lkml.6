Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id MP5/KqOAHlsncgAAmS7hNA
	; Mon, 11 Jun 2018 14:02:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A3C35607BB; Mon, 11 Jun 2018 14:02:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J0z/14yV"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BA9A76074D;
	Mon, 11 Jun 2018 14:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA9A76074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933416AbeFKOB7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:01:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36986 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933371AbeFKOB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:01:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5BDtRqs145863;
        Mon, 11 Jun 2018 14:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=UcVMcRT+o7ftFwZn/wwyxTVZtRHhnGDQWEAnIQ4TSSU=;
 b=J0z/14yV0e48GJA/hvVu3cbdtjvMAosO551wWBcyAZDD+Z99S/+sAlbWyopt0oB7oMGl
 kbf6yGdQQWPdQApZgAAlxnoD7S8iLX4Urx2IVvxiD0vD5aomFz+I1nec0B526NZ9NV9B
 nxmS8xQbEgS+Hw6JJrZWFfI342Q9NJZmZn/fJZJ5Lkym9/DByZ7ZV016OWqHKc5necEL
 baap/ShOo+pd2xOPeggYdtvo0GCQs2xVHkVSqjCtNyUANHGvADtY0ab96uzH9gbp+mZa
 6yxxGbB/65tmBTbgh7ZRZIjkWP9TrgDno8DaPsLJZ7y99E8z9yYzoMh3TwHkECfD9U0L XQ==
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2jgecxcr43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jun 2018 14:01:20 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5BE1JeC027420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jun 2018 14:01:19 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5BE1IYI009428;
        Mon, 11 Jun 2018 14:01:18 GMT
Received: from char.us.oracle.com (/10.137.176.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Jun 2018 07:01:17 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 678316A0064; Mon, 11 Jun 2018 10:01:16 -0400 (EDT)
Date: Mon, 11 Jun 2018 10:01:16 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        tglx@linutronix.de, andrew.cooper3@citrix.com,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Kees Cook <keescook@chromium.org>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: Re: [PATCH v1 3/3] x86/bugs: Switch the selection of mitigation from
 CPU vendor to CPU features
Message-ID: <20180611140116.GA26199@char.us.oracle.com>
References: <20180601145921.9500-1-konrad.wilk@oracle.com>
 <20180601145921.9500-4-konrad.wilk@oracle.com>
 <2a3e0323-7086-f764-1a3b-7ce4891e8784@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a3e0323-7086-f764-1a3b-7ce4891e8784@amd.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8920 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806110163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 04:30:15PM -0500, Tom Lendacky wrote:
> On 6/1/2018 9:59 AM, Konrad Rzeszutek Wilk wrote:
> > Both AMD and Intel can have SPEC CTRL MSR for SSBD.
> > 
> > However AMD also has two more other ways of doing it - which
> > are !SPEC_CTRL MSR ways.
> > 
> > Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > 
> > ---
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Cc: Borislav Petkov <bp@suse.de>
> > Cc: David Woodhouse <dwmw@amazon.co.uk>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: KarimAllah Ahmed <karahmed@amazon.de>
> > ---
> >  arch/x86/kernel/cpu/bugs.c | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index 6bea81855cdd..cd0fda1fff6d 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -532,17 +532,12 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
> >  		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD may
> >  		 * use a completely different MSR and bit dependent on family.
> >  		 */
> > -		switch (boot_cpu_data.x86_vendor) {
> > -		case X86_VENDOR_INTEL:
> > -		case X86_VENDOR_AMD:
> > -			if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
> > -				x86_amd_ssb_disable();
> > -				break;
> > -			}
> > +		if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
> > +			x86_amd_ssb_disable();
> > +		else {
> 
> As I think about this more, I don't think we can do this for AMD.  The
> X86_FEATURE_SSBD could be true because of the LS_CFG support and not the
> AMD_SSBD CPUID bit.  But if the IBRS CPUID bit was set, we would now try
> to use the SPEC_CTRL register for SSBD, which is not valid.

I was reading the AMD docs and while the SPEC CTRL provides IBRS my understanding
(from reading between the lines) is that AMD would actually never implement this.

That is it would have the 'Enhanced IBRS' bit exposed if at all, but nothing else.

Granted this is tea-reading at its best so, ..
> 
> I think you will have to keep the case statements and explicitly check for
> X86_FEATURE_AMD_SSBD before using SPEC_CTRL.

.. we could or alternatively add an extra check for X86_FEATURE_AMD_SSBD ?


I think Thomas already sent this out but it should be no problems to
add a fix as there is no hardware with this so it isn't like we are
breaking anything :-)
