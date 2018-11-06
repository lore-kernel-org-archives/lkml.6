Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72941C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1C12081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1C12081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389211AbeKGBk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:40:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:64724 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387685AbeKGBk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:40:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 08:15:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,472,1534834800"; 
   d="scan'208";a="106356382"
Received: from jlock-mobl.ger.corp.intel.com ([10.252.30.211])
  by orsmga002.jf.intel.com with ESMTP; 06 Nov 2018 08:14:59 -0800
Message-ID: <6c4576c012fca40a08e6db394b4c3620a2879aa8.camel@linux.intel.com>
Subject: Re: [PATCH] docs: Extend trusted keys documentation for TPM 2.0
From:   Joshua Lock <joshua.g.lock@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, jejb@linux.ibm.com,
        Alexander.Levin@microsoft.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org
Cc:     William Roberts <william.c.roberts@intel.com>
Date:   Tue, 06 Nov 2018 16:14:58 +0000
In-Reply-To: <20181106160058.5ov7yhzq6mbrg6yn@cantor>
References: <20181019101758.1569-1-stefanb@linux.ibm.com>
         <20181105204215.hw6vme5epxcc3nch@cantor>
         <20181106160058.5ov7yhzq6mbrg6yn@cantor>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-06 at 09:00 -0700, Jerry Snitselaar wrote:
> On Mon Nov 05 18, Jerry Snitselaar wrote:
> > On Fri Oct 19 18, Stefan Berger wrote:
> > > Extend the documentation for trusted keys with documentation for
> > > how to
> > > set up a key for a TPM 2.0 so it can be used with a TPM 2.0 as
> > > well.
> > > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > ---
> > > .../security/keys/trusted-encrypted.rst       | 31
> > > ++++++++++++++++++-
> > > 1 file changed, 30 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/security/keys/trusted-encrypted.rst
> > > b/Documentation/security/keys/trusted-encrypted.rst
> > > index 3bb24e09a332..6ec6bb2ac497 100644
> > > --- a/Documentation/security/keys/trusted-encrypted.rst
> > > +++ b/Documentation/security/keys/trusted-encrypted.rst
> > > @@ -18,10 +18,33 @@ integrity verifications match.  A loaded
> > > Trusted Key can be updated with new
> > > when the kernel and initramfs are updated.  The same key can have
> > > many saved
> > > blobs under different PCR values, so multiple boots are easily
> > > supported.
> > > 
> > > +TPM 1.2
> > > +-------
> > > +
> > > By default, trusted keys are sealed under the SRK, which has the
> > > default
> > > authorization value (20 zeros).  This can be set at takeownership
> > > time with the
> > > trouser's utility: "tpm_takeownership -u -z".
> > > 
> > > +TPM 2.0
> > > +-------
> > > +
> > > +The user must first create a storage key and make it persistent,
> > > so the key is
> > > +available after reboot. This can be done using the following
> > > commands.
> > > +
> > > +With the IBM TSS 2 stack::
> > > +
> > > +  #> tsscreateprimary -hi o -st
> > > +  Handle 80000000
> > > +  #> tssevictcontrol -hi o -ho 80000000 -hp 81000001
> > > +
> > > +Or with the Intel TSS 2 stack::
> > > +
> > > +  #> tpm2_createprimary --hierarchy o -G rsa2048 -o key.ctxt
> > > +  [...]
> > > +  handle: 0x800000FF
> > > +  #> tpm2_evictcontrol -c key.ctxt -p 0x81000001
> > > +  persistentHandle: 0x81000001
> > > +
> > 
> > Is that the correct option for tpm2_evictcontrol? What I'm seeing
> > in the versions I have is -S or -persistent= for specifying the
> > persistent handle.
> > 
> > Other than that looks good to me.
> 
> William, is the above correct?

We're changing some of the options in master ahead of our next major
release, the -p/--persistent option is correct for that branch and the
eventual 4.X series.

Regards,
Joshua

> > 
> > > Usage::
> > > 
> > >    keyctl add trusted name "new keylen [options]" ring
> > > @@ -30,7 +53,9 @@ Usage::
> > >    keyctl print keyid
> > > 
> > >    options:
> > > -       keyhandle=    ascii hex value of sealing key default
> > > 0x40000000 (SRK)
> > > +       keyhandle=    ascii hex value of sealing key
> > > +                       TPM 1.2: default 0x40000000 (SRK)
> > > +                       TPM 2.0: no default; must be passed every
> > > time
> > >       keyauth=	     ascii hex auth for sealing key default
> > > 0x00...i
> > >                     (40 ascii zeros)
> > >       blobauth=     ascii hex auth for sealed data default
> > > 0x00...
> > > @@ -84,6 +109,10 @@ Examples of trusted and encrypted key usage:
> > > 
> > > Create and save a trusted key named "kmk" of length 32 bytes::
> > > 
> > > +Note: When using a TPM 2.0 with a persistent key with handle
> > > 0x81000001,
> > > +append 'keyhandle=0x81000001' to statements between quotes, such
> > > as
> > > +"new 32 keyhandle=0x81000001".
> > > +
> > >    $ keyctl add trusted kmk "new 32" @u
> > >    440502848
> > > 
> > > -- 
> > > 2.17.2
> > > 

