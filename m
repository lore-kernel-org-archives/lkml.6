Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1017744-1523539213-2-12637084123759206941
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523539212; b=X5D+Sehyh+de8P/je6xDxs0zlPDUwiRlCO1a8A3K1G6QMdPafR
    FCr3Rs7UZH4kyGQC9tdJtltzCXgCCFFe12vlsKvwkxqny00I6ZZEnNNE+LNZAHQr
    dyg/TLdDoqK6LbDS8fUc869+MQyRINjul85BGI/E09+SE3mX+xVTnZGxKdFNLVeq
    R0pP3TSqgDE51UtR1i26vGVFMiY5P0/TlyFDUByMOL8/XJ1jN4iYwPpVb6Qca2HT
    LfZe+3d8q9mtGEWbhsjPBU+63Ngpcdp5cYGLwqpb9+gCWx9mcO8nwOwTxZx/ZoK3
    p/Q1Uz6ERPrzUjJMAdGSiqKzCA/rWBH7e9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523539212; bh=DOS0e
    Dytu/fWgBtP1bxEmgnXcXpF5PS2DDEs/TUaB0I=; b=nTICUFtcW7+2FPuvwMIRs
    eVpVrL//TdFm8fJ0jvGY6Qx3fUEAJi5n/qejvYJD2m47F3u8OU1G35PvONhk8SNt
    1qfxWAruDbXdNz+Rcq8t8mqnNdgLoss7vX7Q75eSf3BcVvLst4m1i0+EpYDMjbFm
    oYvRBcCEr6Rscw8dPZXvHljk7IcBjxkYBmD+3B1B9+KvIGpQaxgN8wcxSe7Ar5Ya
    BLADIt8Yob3v9j23V+eU4r1utNT+rzmA+6autYUw7W3hVGDiuBS+vo/tmHrucoci
    aOq8ywfEBjau0OwboIA2SbLt3w+CLX0xMN0t75GlDNm0YIqvMRx6OVCfDl2qqcmq
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKk3GqaH6Q5+mT3Ix+h7Vf0muOvgXzaYkeVBMklIyHy5EbfFAk9cDzsAceS2EkUTYOnPvhWHBXfZ6j/WBt48eHv2/dB4vFgmYhdrts1bY67JA5tzAmS7
    69BeZlQZ+9a97jWjd1zX1a0KQSc6rC5IpIgum/5k4YitP06LzP9FN2uzj7yDbGf0HevZdfW9b/panmSqG9U28ADAY4ZNV53OJxdXa2Ny7YWmxJWPnG8mkv9N
    0InXF1vx/5KyrCoc7BA//A==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8
    a=gu6fZOg2AAAA:8 a=DDOyTI_5AAAA:8 a=AwHRw0LwDqi03KZ3pwUA:9
    a=bVRYNReHEJy66kRg:21 a=yqXI8oIKUFROb_0I:21 a=CjuIK1q_8ugA:10
    a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=2RSlZUUhi9gRBrsHwhhZ:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE872178E
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=helgaas@kernel.org
Date: Thu, 12 Apr 2018 08:20:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v7] Revert "PCI: hv: Use device serial number as PCI
 domain"
Message-ID: <20180412132003.GC145698@bhelgaas-glaptop.roam.corp.google.com>
References: <FE7CB779-F2C9-4967-BCF1-A0DFE846B2E5@microsoft.com>
 <20180412091742.GA31251@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180412091742.GA31251@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
Cc: Stephen Hemminger <sthemmin@microsoft.com>,
 Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 Jake Oshins <jakeo@microsoft.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 10:17:42AM +0100, Lorenzo Pieralisi wrote:
> On Thu, Apr 12, 2018 at 02:44:42AM +0000, Sridhar Pitchai wrote:
> > When Linux runs as a guest VM in Hyper-V and Hyper-V adds the virtual PCI
> > bus to the guest, Hyper-V always provides unique PCI domain.
> > 
> > commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
> > overrode unique domain with the serial number of the first device added to
> > the virtual PCI bus.
> > 
> > The reason for that patch was to have a consistent and short name for the
> > device, but Hyper-V doesn't provide unique serial numbers. Using non-unique
> > serial numbers as domain IDs leads to duplicate device addresses, which
> > causes PCI bus registration to fail.
> > 
> > Revert commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
> > domain") so we can reliably support multiple devices being assigned to
> > a guest.
> > 
> > Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
> > Signed-off-by: Sridhar Pitchai <sridhar.pitchai@microsoft.com>
> > Cc: stable@vger.kernel.org
> 
> I am still not happy with this patch.
> 
> -  You do not explain at all the dependency on commit 0c195567a8f6 and
>    you should because that's fundamental, if that patch is not present
>    this revert breaks the kernel as per previous discussions[1].
> -  You are sending this patch to all stable kernels that contain the
>    commit you are fixing - some that may not contain the commit above
>    (that was merged in v4.14), you are breaking those kernels, if not
>    explain me why please

If there's a dependency on 0c195567a8f6, I totally agree that
needs to be cleared up.  I was assuming that turned out to be
irrelevant.

> [1] https://marc.info/?l=linux-pci&m=152158684221212&w=2
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
