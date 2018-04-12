Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1364822-1523549629-2-2112370769917587047
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523549629; b=NTYhac4kb5aODTpZ5GCuCm/Q205y9aLRtCbwBdArccY8M0P6tC
    uybfmsT3dDHtkHNEgwmRFmvEXE0zJzimre9sivNM4fZR2DUGEvvUdUhMisIBVHgj
    S4/9JlXqKtGB3fy6D1xPO+/40wkW5xjaZUnkZ27O4AZnPZcmiz1zJ+piSqHskCZk
    qcEGKSGu9rXl5xtVw1cOxRnW+wilob7kZkIxEObhs8aqEJEDOxyENgvjfU6mVeAy
    rF2X3X6azl0uQE0Tck5muYJamBVUmL36FWXI1BPIy0EzebEZN55dqYY6GWDrw4f9
    ssTfHSztgFFgXwaK7IWgKbeBkZ4T9KnHbZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523549629; bh=gyGhj
    vzELqvI6JimH9ni3TLtyhZTUOOcMv5Ezq57W+w=; b=tIszfERoiKXElNZcE1/yB
    0WTO7JlmgxhQy0YLImkTNOtztLSaFVwQ7qXh9RbUS/yke+zblhpmtTFJvSIAcSqm
    zswmGZim1kpLgF0D5pq2yHVrxJ+IYs54K/I7aRZUQUJZ3J2jeGFUwxc6dF78iE2a
    XAiApPgT7dSvcVU19eN17+vkTtn2G4cl5kXHaxlS5ws2xwGuxVUEg5F/M2zFoher
    zDZi06Rbrc7yfHHdibPfwyf06ltW2g1Xg1UAWXfrarB9zJv8d/yNUbqgIqLd99zd
    EUgRzJQm+w+mDK3eOMM9TfsNLLb+WNztlRfB8uCZ4pf0duPsfLQUJuNRltfybuwp
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAfOBmUIyXte6f+UejbwqHjD5AWdtV7SZrcPr93E1RHYEOnJz20pfGXkVh4UzU2snixC942bAiAj17Pr1SZx7eTpcEMDJft0bLZd0Ozu1fHFkVo+UuWU
    XMWgbHnSZ6CBHVzD/LNNgJLOkLALgT7Wh5UCVP+Wc7gw4gDLngWd+uWU6OC22qVe8pqj0IjDZMjYcwlGs/RwS03LqcZLl1EcIg+4cRdVkIXUowabiX+b4OVY
    nNCRr9+t50Bh9qRtSbjkyA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=gEqCvu4LKmXjwy6zU4cA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 12 Apr 2018 17:13:34 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Subject: Re: [PATCH v7] Revert "PCI: hv: Use device serial number as PCI
 domain"
Message-ID: <20180412161334.GA5803@e107981-ln.cambridge.arm.com>
References: <FE7CB779-F2C9-4967-BCF1-A0DFE846B2E5@microsoft.com>
 <20180412091742.GA31251@e107981-ln.cambridge.arm.com>
 <20180412132003.GC145698@bhelgaas-glaptop.roam.corp.google.com>
 <9832EE81-01B3-44AB-8B3D-EEA32AED07E0@microsoft.com>
 <BL0PR2101MB1108227C3E52DE4462A9F93CCABC0@BL0PR2101MB1108.namprd21.prod.outlook.com>
 <F8BC8B81-D3A4-40F7-95F4-CAF77A7917B7@microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <F8BC8B81-D3A4-40F7-95F4-CAF77A7917B7@microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Jake Oshins <jakeo@microsoft.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 03:56:42PM +0000, Sridhar Pitchai wrote:
>     > 
>     >     >> I am still not happy with this patch.
>     >     >>
>     >     >> -  You do not explain at all the dependency on commit 0c195567a8f6 and
>     >     >>    you should because that's fundamental, if that patch is not present
>     >     >>    this revert breaks the kernel as per previous discussions[1].
>     >     >> -  You are sending this patch to all stable kernels that contain the
>     >     >>    commit you are fixing - some that may not contain the commit above
>     >     >>    (that was merged in v4.14), you are breaking those kernels, if not
>     >     >>    explain me why please
>     > 
>     >     >If there's a dependency on 0c195567a8f6, I totally agree that
>     >     >needs to be cleared up.  I was assuming that turned out to be
>     >     >irrelevant.
>     > That is right. There is no dependency on 0c195567a8f6. We just need to revert
>     > 4a9b0933bdfc.
>     
>     > This patch should only be applied to later versions after  0c195567a8f6" (transparent VF).
>     > Otherwise it causes long & random names of VF NICs for bonding. That will make bonding
>     > config difficult, especially for auto config.
>     
>     >Thanks,
>     >- Haiyang
> Ok. I will update the patch, as Lorenzo suggested. 

Please update your email client quoting policy so that it does not add
unnecessary indentation spaces, for long threads this gets messy.

If you send a patch to a specific stable version you have to test it
first thing on that stable version before adding a stable tag, reverting
a patch from stable kernels is the last thing we want to do - that's the
reason why I keep complaining.

Thanks,
Lorenzo
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
