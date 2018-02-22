Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-293599-1519308744-2-16787154168983652152
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519308743; b=E7etpVMzKD4buctjKvjfZlDyprf/gKj9K4Xq7PU6fFe+eIk
    dmS5Q3f96MuvfJVBJ6KwL1yUGY+XYr8JVaDgA8Mj/OwMUsQj6/dbUIUQOK6cF4ld
    /7++6oRfqanNLMTs2S03iJ2xUlPgmahWG98V7IYWBSSBmyBhhgUmKfG0yADTvIV7
    dPEpl8CaEhwA7uNdO0cO1DZdx8yGzI89hChgzLmTBFVgBrvXbub856UFy5fz4Co4
    fn1QyJI8Q/rCN4wbkyNYKbUOFw9ht/2p1WjaVz1mdGAnSHu/Cs4E+RUWbKay6u+w
    gHjJ1w4xEMApdMbfMCX5hRtwN5P+ebpE9GS+FCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519308743; bh=P
    qXwxKQ58ccspgY80IueRgg+uzOxlE82Vz4W7fGw4Bk=; b=nv2L1rjRCMNbctUF0
    CGJgkL7g4JeU5geyOq5xFa076+Ev0Yv00ZZ1LRdL5t9hBVX46R3swP2+x4ZdlG1l
    4CjYdmvDx0bNL74mdu/TlfrFjtMaPZ5u6n5SSOO6srxLKbTJ1vRNPvyMxaCKkcxx
    XnfMMRglwBXXAUpROWcRqUlGsa0QXiv24NcWn5HptIPB9ajjwTfMIg/kAzT/IDyR
    nvey9uyw4aKUZu8+PBuiOUllHpbuecfVPGrFcKiha0zwsEoHkjwGW9dRFN9p8bFO
    p6S3ucQP3qHx9N5PweNHxJvzbdUsTcf6Uj8B3Hx2eLeCVnFvm9Bxmj1LKwLxUMQw
    ADfjg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 22 Feb 2018 15:12:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bogdan Purcareata <bogdan.purcareata@nxp.com>
Subject: Re: [PATCH v6 0/2] staging: fsl-mc: Move bus driver out of staging
Message-ID: <20180222141217.GA19330@kroah.com>
References: <20180205140743.29974-1-bogdan.purcareata@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180205140743.29974-1-bogdan.purcareata@nxp.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
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
Cc: devel@driverdev.osuosl.org, robh@kernel.org, stuyoder@gmail.com,
 arnd@arndb.de, marc.zyngier@arm.com, roy.pledge@nxp.com,
 linux-kernel@vger.kernel.org, razvan.stefanescu@nxp.com, horia.geanta@nxp.com,
 nipun.gupta@nxp.com, ioana.ciornei@nxp.com, tglx@linutronix.de,
 jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org,
 laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 05, 2018 at 08:07:41AM -0600, Bogdan Purcareata wrote:
> Previous submission: https://lkml.org/lkml/2018/1/26/215
> 
> Split the code into moving out the core bus infrastructure separate from
> the irqchip glue code. Add a Kconfig dependency on ARM_GIC_V3_ITS.
> Integrate the documentation with the kernel build system.
> 
> This patchset only handles moving the fsl-mc bus core out of staging.
> The remaining objects (DPBP, DPCON) and drivers (dpio, dpaa2-eth) will
> be moved out in subsequent patches.

Now applied, nice work everyone.

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
