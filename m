Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3643183-1521225096-2-15295716875390213894
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521225096; b=GX5znDfO2vLhRUIjZogugnP/WRdeanezh1gb1kkP5LsvjS7
    rCNJmz3pjMfjRT0ZetnZjO/nU6y9YzmhtNCgnMtbqXqurB5WvYuG5p3YOKGybfYU
    We0k7Rt7nI4GCFKs4BnLXnJkJXaywHcGfX/dVzXdojkEZQL4YkVTpbFiYC5SARX3
    9dgTLvXz2iz7DZrVx5yIxk494/oDf8KIhA12IsFuXE1doNyugGFSKMKbTRonVvYr
    7kdwbrmVxXn8NQwx4XKFEPF7MgNuFA+OFPvO//bABFZoRJHTR8Dy7Yw5RI59URvk
    DWcVaa/QaS6YQ0VbKxOuv5f8PIbW89EjTU9NZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521225096; bh=M
    OOpZc6bOVO2o8TFYuCHaIvx/KTBBFspRRME8qq9Fjs=; b=M2fFiShIZ5LGsznD1
    GN7cD1xVj3cQKEkiW5D4ZGrRDvkXwnilORVVUCNCK1VATDg4+I3usodwD9UIKmoX
    GiCfPwZ9T3PVeDRhs+16sevMejMr5X13ZBTDv9zYb42IJtZicthyZZYRdTmeKGSH
    9xv6tZnCHg0/tczEzcw8E5/b3rsmoEg1vE7p1/rKL7qOKQnfCzGrp1bdMtC50yas
    LlzJxA7gotaGu4lrvwXGmNWniG4mvbU35UfCSq+L8eAMA/kat0Yx748JR46vQdmE
    qSLzznzf5UQdkQvWzYegZ8Gya/Gky1VOPI/9MpCmvDwh9MfMPNeGuoUq17PcY5Q9
    +isVA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 16 Mar 2018 18:31:58 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v4 3/4] PCI: hv: Remove hbus->enum_sem
Message-ID: <20180316183158.GA13569@red-moon>
References: <KL1P15301MB0006E2FA71F87B312D9DECA4BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180316105424.GA24198@e107981-ln.cambridge.arm.com>
 <KL1P15301MB00064DA6B4D221123B5241CFBFD70@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <KL1P15301MB00064DA6B4D221123B5241CFBFD70@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "driverdev-devel@linuxdriverproject.org"
 <driverdev-devel@linuxdriverproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 "apw@canonical.com" <apw@canonical.com>,
 "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 05:41:27PM +0000, Dexuan Cui wrote:
> > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Sent: Friday, March 16, 2018 03:54
> > ...
> > Dexuan,
> > while applying/updating these patches I notice this one may be squashed
> > into: https://patchwork.ozlabs.org/patch/886266/
> > 
> > since they logically belong in the same patch. Are you OK with me doing
> > that ? Is my reading correct ?
> > Lorenzo
> 
> I'm OK. 
> I used two patches
> [PATCH v4 1/2] PCI: hv: Serialize the present and eject work items
> [PATCH v4 3/4] PCI: hv: Remove hbus->enum_sem
> only because the first fixed a real issue and hence IMO should go into
> stable kernels, and the second is only a cleanup patch, which doesn't
> need go into stable kernels.
> 
> Either way is ok to me. 
> Please feel free to do whatever you think is better. :-)

OK, patch series reworked and queued in my pci/hv branch please have
a look and let me know if that looks OK for you, I won't ask Bjorn
to move it into -next till you give me the go-ahead.

Thanks,
Lorenzo
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
