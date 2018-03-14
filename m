Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2930480-1521071091-2-12162390178626378770
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='ch', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521071090; b=KZvv7n9u/MMba4dLgCOz7yLaVyrg1mm+MpZIOwJFHYe7RdO
    9cJUNJficTv9Jx82QIAmcmhhrIPZN6v8UJRWrxoL8gFMeS9crBDtBh4LV9jO4zhw
    IwWGfWmdM1Rty6Rxjtn3e1JMQGiqfzoyj5p4n8zoksNPFGcjsfbEZT6Ra+7M8cb0
    w0q53MADk9bhXn+nuOcD9JPvcWeYYnqUQRwDWPUjOOskR6J59By7Moxipt3DLvVE
    I1+cQX6ZMi9hqAPh4CPb7kQ72xnAYGXHwsTJTrkyr/UQ66UT24Qw+JKqBfCKnSM7
    9IyYUZimu5oezkIVkOLlOorZiLK5v12H64x5lMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521071090; bh=q
    YXH+Uv8HflPo0WP8MPH9+UoGL95LsZpgFoJauIUAHc=; b=ZvUnbLPVm11dcCb58
    mYy0VG16KAtTwTKmAh6QrlAexH6aCL1tsqNBba8TfaigtfR+92pBMe8VR1vdsNab
    f/iEfvbxt+ADfSfgDB3ga6oscBX3kVRu3ZAGmvoxuUY/m8FVwpVCRH40mVNJ84/j
    0pvTiPE6drwt+2XENzfm00uBElm0xtkx18ivNU2oAsP09dJDSOPqaH6YaGo4JSKk
    4k98AbD+Lweo+VYN0Fldo0mBvJtq0eVz+muo7V9fPd5xz4G8+p7U9vC4AWWkOufb
    cSygAn/FBMxiDtEmT+8jXxEFfE0ts1vtKgE9SCyNdC2YxbxyIKJDzUH1uzFf8CjE
    0PNtQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=SZbFW8T/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=SZbFW8T/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 15 Mar 2018 00:44:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Razvan Stefanescu <razvan.stefanescu@nxp.com>
Subject: Re: [PATCH v6 0/6] staging: Introduce DPAA2 Ethernet Switch driver
Message-ID: <20180314234437.GD16379@lunn.ch>
References: <20180314155558.6898-1-razvan.stefanescu@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180314155558.6898-1-razvan.stefanescu@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
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
Cc: devel@driverdev.osuosl.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 ioana.ciornei@nxp.com, alexandru.marginean@nxp.com, agraf@suse.de,
 linux-kernel@vger.kernel.org, stuyoder@gmail.com, netdev@vger.kernel.org,
 laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 10:55:52AM -0500, Razvan Stefanescu wrote:
> This patchset introduces the Ethernet Switch Driver for Freescale/NXP SoCs
> with DPAA2 (DataPath Acceleration Architecture v2). The driver manages
> switch objects discovered on the fsl-mc bus. A description of the driver
> can be found in the associated README file.

Hi Greg

This code has much better quality than the usual stuff in staging. I
see no reason not to merge it. 

    Andrew
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
