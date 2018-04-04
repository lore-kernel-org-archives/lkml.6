Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-426418-1522857431-2-5963458811734798347
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522857431; b=EJ6x7H8sQktce669ZpXjPTEv0ldEdomylPgUUSPLdgJNUWSlul
    dXQ04S/0/+b41bUpjUORYh+biZ8roNOu5b6X+2CmgqzkkiSYBG4BFdN670nuK8PR
    KYWU2oLMXfBHogJ/Gf7yL3npgSbdGQ1sI2QwyE8ObaE1rqx+WoEzmREhrjWagqD+
    Tuk8VMVOcBUXbvJfCuyQGxD8dSVjCUz09/vQzuuozjp7yH8IX+we0he5fmViWjDu
    t6JWsMdcAJw6C1xZo6hZ/HO7zp876/IGJhCkizYoyt41Z/LmEhv+lO74FkTgCCXZ
    0opG+4CeHOB5aazm04t/BwaIHn+nupPhZlsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522857431; bh=Bc0wQ
    fiyN9fIRBpI/gcm04buUQkfNfh+8jiGq6rB1+0=; b=mwxBzq5WNrsaGTdObjO3s
    L6iT6ihQR+63y4qVJ2pHxPZW/Le6g2l1cez+Dvs2uMPWVlDljJWS/7HbnZfk6vMi
    KMWqQaeT7H37HFrFkIW1aFZkbwRfIh+cAdL4zRM1EQsFoT6DGTivSzv5PqaZkWK1
    NAYQlQgUa8fR/hPsa+6hFZSnXwcq0IK80+4ps7BCAjTSLqAIAZCcUYAa4tkbvrkt
    a3i0egLOo+PkcGrV/LrPJQ2YGEwAj0gvZkyPygJudOi/7L9kVz0LTLhu9VJwR3sw
    t/66MMltdFyrmIbV7CgHaaef4j3QDooNfDMvYIe2Ob/WouZ+VDq39oZ8BRYLYz2E
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDugWdNBBFBdU9trvsCAgL1BTrM2N7CVy/ipYvsZKYX8MGOqGX+BSrQxtQx+7NLBYTzTPMJcTFViR7TfzpHkhKO/wHU1cMcXuiS+qQyWhCJ/lim4zCAM
    rfKPb4pvFsvvlTvrkpxNRfaT592u+HJq+oK1q4opPa3EGzhaCIUk6+f4nmA8e0MzmaRDWi4UstHfEjsnk2q1zLvMUi1l4X1Ogeo55JCGyy1y/xywn2B778bu
    CDTS9NMrY6b4ma7IyiGVUQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8 a=yMhMjlubAAAA:8
    a=VwQbUJbxAAAA:8 a=DDOyTI_5AAAA:8 a=DfNHnWVPAAAA:8 a=20KFwNOVAAAA:8
    a=pGLkceISAAAA:8 a=D19gQVrFAAAA:8 a=9ytbwaJxvL8hWYPFzPAA:9 a=CjuIK1q_8ugA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22
    a=rjTVMONInIDnV1a_A2c_:22 a=W4TVW4IDbPiebHqcZpNg:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 4 Apr 2018 17:57:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: Re: [PATCH v2 char-misc 1/1] x86/hyperv: Add interrupt handler
 annotations
Message-ID: <20180404155704.GA5891@kroah.com>
References: <1522789148-1787-1-git-send-email-mikelley@microsoft.com>
 <20180404081629.GA22277@kroah.com>
 <DM5PR2101MB10306FD0D4DD653D7878C2BEDCA40@DM5PR2101MB1030.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM5PR2101MB10306FD0D4DD653D7878C2BEDCA40@DM5PR2101MB1030.namprd21.prod.outlook.com>
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
Cc: "olaf@aepfle.de" <olaf@aepfle.de>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "apw@canonical.com" <apw@canonical.com>,
 "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "leann.ogasawara@canonical.com" <leann.ogasawara@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 03:47:03PM +0000, Michael Kelley (EOSG) wrote:
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Wednesday, April 4, 2018 1:16 AM
> > To: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
> > Cc: linux-kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> > apw@canonical.com; vkuznets@redhat.com; jasowang@redhat.com;
> > leann.ogasawara@canonical.com; marcelo.cerri@canonical.com; Stephen Hemminger
> > <sthemmin@microsoft.com>; KY Srinivasan <kys@microsoft.com>
> > Subject: Re: [PATCH v2 char-misc 1/1] x86/hyperv: Add interrupt handler annotations
> > 
> > On Tue, Apr 03, 2018 at 01:59:08PM -0700, mhkelley58@gmail.com wrote:
> > > From: Michael Kelley <mikelley@microsoft.com>
> > >
> > > Add standard interrupt handler annotations to
> > > hyperv_vector_handler().
> > >
> > > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > > ---
> > > Changes in v2:
> > > * Fixed From: line
> > > ---
> > >  arch/x86/kernel/cpu/mshyperv.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > > index 4488cf0..20f6849 100644
> > > --- a/arch/x86/kernel/cpu/mshyperv.c
> > > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > > @@ -41,7 +41,7 @@ static void (*hv_stimer0_handler)(void);
> > >  static void (*hv_kexec_handler)(void);
> > >  static void (*hv_crash_handler)(struct pt_regs *regs);
> > >
> > > -void hyperv_vector_handler(struct pt_regs *regs)
> > > +__visible void __irq_entry hyperv_vector_handler(struct pt_regs *regs)
> > 
> > What bug does this solve?  What is wrong with the existing markings?
> > What does __visible and __irq_entry give us that we don't already have
> > and we need?
> > 
> > Are you really using LTO that requires this marking to prevent the code
> > from being removed?
> 
> Thomas Gleixner commented on Vitaly Kuznetsov's Hyper-V reenlightenment patch
> that the interrupt handler should have these annotations: see
> https://lkml.org/lkml/2018/1/14/145

Ok, then someone needs to put a "Suggested-by:" or "Requested-by:" or
something like that tag here, right?

> I put the same annotations on the interrupt handler for stimer0 Direct Mode,
> So this change makes the hyperv_vector_handler() consistent with
> hv_stimer0_vector_handler() in the same source file.  It does not fix any
> immediate bug -- it's for consistency and alignment with what is apparently
> standard practice.
> 
> Not sure what LTO is ...

That's what the __visable marking fixes!  Please go at least _read_ the
definition of the marking you are adding to a function before doing it.
Otherwise this is just cargo-cult-coding :(

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
