Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-515744-1520864995-5-5555866103184350803
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='ch', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520864995; b=Vhq62ucGhUXZ8icGTWO2gI0Ayc0WdsWp9a9qdZ94p+vSgbQ
    9UJuyAzASTIlwo73AF1MYan9iPmlKK4JfbFXUKoo45HzsYOY7ByGWAX+wmBOCz7o
    CSzDUend8m3PME/gYTfpQ6PkgK7omH/LkMnjhMRNUifL6Tf01M7j/PylSVhaBUgF
    fBlLeCDU5LiTmQMLVNkx4y/eRJeDeAqGKaOYg+6sC0OCBtzGwJHmLM5rM7y/QTMW
    GLWiR8b4G7A5EgdChTn5NODFmcNRETHPmJ1jJHBTmzqqiM7MMFRTWxxIcQVvDXlJ
    Gqs1GmVGJP8R8ujyqTbnfEPE2dB0lR03qPj4p3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520864995; bh=A
    nQiMyGF/VcVjdn2+V+mSj7k0B+/Qdr+gaS2K/srL0k=; b=TnARkO+xtc+JuzRuE
    4M2XxjbOQ6XwKd1zT+nuUAytkFFRCzBVkqdDPBoEUuRVMCRdddMXKug9ko43ZVL1
    YSGkWsYVU5juCTTKcESP6/wls0V6cG5/iDRPpjZTs26sDIoJFNOqvXRIi4EdRsn6
    xM+jxcY9tAtvUYyxZSbstBcJi2fwzEWqWY1Ew4JGTBYVaZs2funA92zwI2CRzhp5
    TPCrFIUEl07YWNAiGKhlqXcOohC80mhyd9fGLQ54TVJr0qs3eFfP1Ge3LV31kfcx
    1BmQLUJWDCyihdr6WmfTEdcmUxBziPH3sfez9OaTIAhbqQhBxzV91UoEnbfVeglW
    9ylLw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=Gxbo9owT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=Gxbo9owT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 12 Mar 2018 15:29:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Razvan Stefanescu <razvan.stefanescu@nxp.com>
Subject: Re: [PATCH v4 2/6] staging: fsl-dpaa2/ethsw: Add Freescale DPAA2
 Ethernet Switch driver
Message-ID: <20180312142940.GA21068@lunn.ch>
References: <20180312084955.12686-1-razvan.stefanescu@nxp.com>
 <20180312084955.12686-3-razvan.stefanescu@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180312084955.12686-3-razvan.stefanescu@nxp.com>
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

On Mon, Mar 12, 2018 at 03:49:51AM -0500, Razvan Stefanescu wrote:

> +static irqreturn_t ethsw_irq0_handler(int irq_num, void *arg)
> +{
> +	return IRQ_WAKE_THREAD;
> +}
> +

> +static int ethsw_setup_irqs(struct fsl_mc_device *sw_dev)
> +{
> +	struct device *dev = &sw_dev->dev;
> +	struct ethsw_core *ethsw = dev_get_drvdata(dev);
> +	u32 mask = DPSW_IRQ_EVENT_LINK_CHANGED;
> +	struct fsl_mc_device_irq *irq;
> +	int err;
> +
> +	err = fsl_mc_allocate_irqs(sw_dev);
> +	if (err) {
> +		dev_err(dev, "MC irqs allocation failed\n");
> +		return err;
> +	}
> +
> +	if (WARN_ON(sw_dev->obj_desc.irq_count != DPSW_IRQ_NUM)) {
> +		err = -EINVAL;
> +		goto free_irq;
> +	}
> +
> +	err = dpsw_set_irq_enable(ethsw->mc_io, 0, ethsw->dpsw_handle,
> +				  DPSW_IRQ_INDEX_IF, 0);
> +	if (err) {
> +		dev_err(dev, "dpsw_set_irq_enable err %d\n", err);
> +		goto free_irq;
> +	}
> +
> +	irq = sw_dev->irqs[DPSW_IRQ_INDEX_IF];
> +
> +	err = devm_request_threaded_irq(dev, irq->msi_desc->irq,
> +					ethsw_irq0_handler,
> +					ethsw_irq0_handler_thread,
> +					IRQF_NO_SUSPEND | IRQF_ONESHOT,
> +					dev_name(dev), dev);

Hi Razvan

You can pass NULL instead of ethsw_irq0_handler.

    Andrew
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
