Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1533320-1521817296-2-6907758836241944709
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521817295; b=egoxkKMVX8AynC46Z01po58j08QGFj4S/PW6htzY0ok1RUd
    /edr0JFO1xplErBwgPJbElkfVnechJRV3dDO7UTwgaEhLRnFwzpUp4WvQuN32DpA
    8D874RWCbhBI+h8KaaWHqvufXtCsSEVphlX6sVn4bH80WYSA/EM9bXP+wsXPtKOW
    rvO2uBLBVlSQ/DF9pmFf5Vv/h+R8aY22uvurMJ97eAHCH4PLfmZnN/gy9RGl2Z9l
    wHzSjrNwdo1IG4lFpdIcYyvDOAwbQI+xYR04vBmoHkmp4GbB+Wk/ABbDRgB78jcs
    6XLYeoFabF/VcbfiOrjeKEJDYSE0+ExfqsnGQUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521817295; bh=O
    f+imaLqlsUy5M98EIdksjqH5jr2lCYoO/gfC1Ca1Uo=; b=gADcezl1uHSgWVWfg
    bbwXsI/li8ZP9/kJJIBdwRBkMRXS+9lxAMqfx3L4xVbU2O+ItsYlmBnHaBHJKVzI
    aLA8EN9gD3QLWYey2jV8ik8dfv7jAL5Zwj2tOVk1otiLH3/VQe57lyUCal3ui8a8
    XTx5RiNeIu/TqNfZFlu4bwWQhTTKMWgausUy2E6n9kK+HSwGVjJrIvhEp659URCy
    t/A+FRY53tpoFnKhd5Qk3g80s6vYvHshYRJ8yqTg8qZA10qTpfYGp2iT5O8oaHlw
    KuYcIGbyroiti3U35Sujh8bHnPhZLl7wFFoKPDiwAEW2WII/LmOtdsIxqVCUkiUp
    CstaQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 23 Mar 2018 16:01:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Subject: Re: [PATCH 2/9] staging: fsl-dpaa2/eth: Move print message
Message-ID: <20180323150126.GA12656@kroah.com>
References: <20180323134413.1532-1-ruxandra.radulescu@nxp.com>
 <20180323134413.1532-3-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180323134413.1532-3-ruxandra.radulescu@nxp.com>
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 08:44:06AM -0500, Ioana Radulescu wrote:
> Let the driver remove() function print an informative message
> after it finishes removing the network interface, not at an
> arbitrary point during cleanup.
> 
> Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
> ---
>  drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> index beb5959..9fb88f2 100644
> --- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> +++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> @@ -2550,7 +2550,6 @@ static int dpaa2_eth_remove(struct fsl_mc_device *ls_dev)
>  	priv = netdev_priv(net_dev);
>  
>  	unregister_netdev(net_dev);
> -	dev_info(net_dev->dev.parent, "Removed interface %s\n", net_dev->name);
>  
>  	if (priv->do_link_poll)
>  		kthread_stop(priv->poll_thread);
> @@ -2571,6 +2570,8 @@ static int dpaa2_eth_remove(struct fsl_mc_device *ls_dev)
>  	dev_set_drvdata(dev, NULL);
>  	free_netdev(net_dev);
>  
> +	dev_info(net_dev->dev.parent, "Removed interface %s\n", net_dev->name);

Why is this even needed?  I'll take it but spamming kernel logs for no
reason is not a good idea :)

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
