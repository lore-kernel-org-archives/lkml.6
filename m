Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3186171-1520946886-2-11309330083175674007
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520946885; b=VsqP+koCM5l3/A2e+auQl9rNugWtKkCsFTuZICPZmV2FbP0
    h/3fEhAr/zMe2QvcthfaQPv5ENL5lBC4aaFiWy0y87F3GyoUrfq7MwxXGFohsTeV
    bnNXbLsSpkEpGS5fJ64r9SioEC70FrYylRoY+REERFOLXSZBOvZGOpb9rWIe4iHM
    zm5vTds0grBN+Q7J+gwTklVlOq513hB/0lxE34NQJXqbw26/DJ++jcG+icQESasJ
    zQ9sIB+cX9ybLOa7U/wrunriidnDIzmhkPHyLHqGOS4FD4uVGOawcrtmIhEiNSwn
    LX4D70tzEMiAlzzVmG1UsKdhMOZRmIjiJ+cCJHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520946885; bh=P
    lv7AT1iDg+d4+h/qbYDV/RAuqqljyPM0yBjLkadL0o=; b=cGG/orfZ0JilH+wiW
    2+qiioeRp3L6elBjh/Auojw3Z+aGNQDlt3JzwLsaTAtX+L3avJHJ5NlpMFbWyILr
    5WkTMdjnx3bAb6y/2DG4sGq/59PPT05aFST9TYT7ri3J4OTVPlMA350qox2xE/ht
    uYnJKUAWyBoqVUdgjgUYLUV/bDLsJKOQN3UsxQTc/u9GkcpvL8ma6lDrrOoJ1PSn
    89lyuVgnNO3kNgA2iNIU2WjVmpXGzsMHSno8dYnqN087U0oC57XJ2MMhGijlPraQ
    ibEpQfBnKODnAEGoyq43hu5qpvRSGuOnl+xgH45x4efi+ZtntuXfPhxgtmzmBgnG
    +jxpw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Arnd Bergmann <arnd@arndb.de>
To: Steve Longerbeam <slongerbeam@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] media: imx: work around false-positive warning
Date: Tue, 13 Mar 2018 14:14:09 +0100
Message-Id: <20180313131422.40710-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:lwgeH8CYbjofM9DV/o1EmbQj3gPLA75y4SaqkfjMdCulfsc/oZj
 lE1xNKLLgvJOhsb2IemsGnyMw/9a+5p6hK/fhYdHo5EYvakoVf5VdVJpADXFeMXMuMhvUnt
 t2mP076VIzvkn9KTw8gFi8WgW65IEm8BLDcQwRiralJGV3jPE2yFVzMY+9niy62jxRqb2hU
 xRd7/Q8YwzLTxBbS7ReiA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BjZm+/uAie8=:dl9ltLvt+GRUXrSO/CkcnV
 8VHrlRSnm5tVZt4ODuV7MOIx8nyGcH8QuQlhWPV+p2BcsO1k6s50en5XdzcJy/ZS/GkqX/YwT
 9GJZjtn2IJAtZQE+Pk5VhJFkD62Xg+P4IFwOQ3HdXeoHK85aG91mQhR0wwsGx96k5d696qi6n
 7jaeA9kIbG4mdOOaAP6toKkVnDNWPQTQGd+1iiSgFzI25ty8qicmG4KtR48Vuvef7Hhiz3BE4
 /UlSgM4Y2XgWURJGW0FXaqBztmdI/4WsDW9ukpryGrgaOI6dAvZTV4y7FWuGQXyduvPIlZ17j
 7dbYk5/jgb0Oh5sIVrSW7I5rqA9eqIxFP2u7qo5EZciX6GF6Vx/Nn5e2faMYbKEgGZSm7bPkw
 +E+zM15uP7Em+dw/3mULgzNkAQsy3AoYYAT1rgjhB1bmL5IxKRpl/jPEZEEbJonr01361SPaL
 EMJ3I6S+GgSzJ+ELwXTFYEhgnBCbHMjFV9bOCKC0oybonR6FNgFY+46Wi5ojRal0ioFxwNeoV
 ePwVaLQuhqJSZVVdJ0Ddpu/b+wU3VkgOTzhew+aKyy5Ui1SPCkPigtnO848ax0qBNnkZoR3YE
 hjQHGbzRKV5F/U0TuBkYuF+j+PQ8hMg7L2l/VIGr76f1lj98+QOtjwCMhKmlubjN9cOESuev7
 mENYAmK0/px3WVnLca/kxhmPtY6WNBEfHAWI8rVDz8XmOjwIo6uzoTb266RUUJLbsDd2FSDop
 egCzENiNyUXChelC1BFgpOdux79jBwGfadx3VA==
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
Cc: devel@driverdev.osuosl.org, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
 Hans Verkuil <hans.verkuil@cisco.com>, linux-media@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The IS_ERR()/PTR_ERR() combination confuses gcc to the point that it
cannot prove the upstream_ep variable to be initialized:

drivers/staging/media/imx/imx-media-csi.c: In function 'csi_link_validate':
drivers/staging/media/imx/imx-media-csi.c:1025:20: error: 'upstream_ep' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  priv->upstream_ep = upstream_ep;
  ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
drivers/staging/media/imx/imx-media-csi.c:1026:24: error: 'upstream_ep.bus_type' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  is_csi2 = (upstream_ep.bus_type == V4L2_MBUS_CSI2);
             ~~~~~~~~~~~^~~~~~~~~
drivers/staging/media/imx/imx-media-csi.c:127:19: error: 'upstream_ep.bus.parallel.bus_width' may be used uninitialized in this function [-Werror=maybe-uninitialized]

I could come up with no good way to rewrite this function, as a last
resort, this adds an explicit zero-intialization of the structure.

Fixes: 52e17089d185 ("media: imx: Don't initialize vars that won't be used")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/media/imx/imx-media-csi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 5a195f80a24d..887fed0c3ce0 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1004,7 +1004,7 @@ static int csi_link_validate(struct v4l2_subdev *sd,
 			     struct v4l2_subdev_format *sink_fmt)
 {
 	struct csi_priv *priv = v4l2_get_subdevdata(sd);
-	struct v4l2_fwnode_endpoint upstream_ep;
+	struct v4l2_fwnode_endpoint upstream_ep = {};
 	const struct imx_media_pixfmt *incc;
 	bool is_csi2;
 	int ret;
-- 
2.9.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
