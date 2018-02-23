Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3019937-1519393922-2-5209029504753375352
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: from='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519393921; b=KRUKXwYA4o2CUBeUxfVIEYpbRLVQqF39kvUDw23ijBVONdo
    OdQZI0WIQFAmwL59rdVS6y61NbhEU6h/riolraFH9KL6XwD3VE5+y4QMpLFI6jBN
    y5jwjL2nwhWIFyz++mdvR9idWWN1WtR6Eh1n2PDeZAyG4ktssSy1EvO+slorKFWI
    NM6QMFgaFHEdg/Oa2Ko+EnnPtfvIAusb3VOvn3JFEGcJx6UhVXehmrS1B4deVVib
    odnsAQwB+789IKpfICeY6L659nALWFIpb1jxNRen5XCyE4gNqBsTBnLDsyrNikj/
    hGwI8m4Sb5wSIyzY6icX/lQSfnMEP1UaXIGlYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1519393921; bh=eofMl56
    T19sVu4iTFC60M1SPhLCAccBE7kf/yKCA6sc=; b=dlHLcFKQGZZYzqc9G0pFnCw
    XCno/ODR12dQwLcveg5gmlq4mPbEBvp8JBW1CdTKecKHcRWwW1Ec+dIUs8pNeqCN
    OtZCo99N2bup+me5s9FabvBVp7Fy/7oGLieb5iMP65pOQLJnjFXBoN4sLm+HKDL4
    Q78MX1WA7K9W4GwgGn/+vXQ4i4e5hzH9Tav1jhlyLVlYz+2mmX5MCXF2Yk6IBcLQ
    eV2t0ctw/fgnkPlUp8XhvxnEh7tRNQUBTk8IuipP8Vg8ptOSBcgf7zkfZ33F6uY+
    fHzBpTCFf+hYe6TPlFNr8vB0+BV6k/4NsCR/y+ECii111+1u6sqYvcdRYLstPrw=
    =
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=pengutronix.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=pengutronix.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeBWNv7 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 08:51:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52467 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbeBWNv6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Feb 2018 08:51:58 -0500
Date: Fri, 23 Feb 2018 14:51:29 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <baohua@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Jiri Slaby <jslaby@suse.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] serial: imx: Fix out-of-bounds access through
 serial port index
Message-ID: <20180223135129.lvk3rgepyuik7a2y@pengutronix.de>
References: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
 <1519393117-31998-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519393117-31998-4-git-send-email-geert+renesas@glider.be>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 02:38:31PM +0100, Geert Uytterhoeven wrote:
> The imx_ports[] array is indexed using a value derived from the
> "serialN" alias in DT, or from platform data, which may lead to an
> out-of-bounds access.
> 
> Fix this by adding a range check.
> 
> Fixes: ff05967a07225ab6 ("serial/imx: add of_alias_get_id() reference back")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks for your time
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
