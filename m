Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2927865-1522393952-2-15729070270539534143
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522393951; b=qokBpHsmuYZMJIW3idTH6RkINf9Sdtj5djYKf/7CZ2XjSpnKXI
    4lxh17oV+yWiInVtW3lRRhxkZ11P0qZyWur8w67L0Abl2wnthxRyVbdShnLcJ4Z6
    aXDqLtYluSN8srN2XUjvHnXz8losZxdZhILrdFpf8rvRQfTcMvaRVXWj86dkuPB/
    7YC/WBJGB4yg8bzqaeeLWO2v1UKKz2Wq4FxV7Az5rIzCH//XTB0LvVZS4uhM1xkj
    tdjfRScD+eYy8boc+hGVVlsM/uWEQBRsUKpNTJPwjxwoeeoamIbJsnkp2yw1b+Ay
    jBcU2FRq/Wwwc1tMWTjGeScVMd80jZbODnlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522393951; bh=29+pn
    QAi3xSMrlroUI65P+sI6G0vaWrQFJ2nsd8cEoU=; b=M1Mie8yhqfjkx1Tl7YQm1
    e9bRgO9MJ/OM4VNRWNgfJwoUsepp73kdj+nIW21PGyTXq1fTLLx34UxrBQhZPEhb
    lJdkOBbYgjUDdx/EXgp+2HBGnzGWSIj3W55MT+oR6qmWeKgjcBhjBcFCa/uSCq6r
    zDU11g8BT069J+QETmLDBgK9rIIgPTx2TREcbIL022QkVTwCjHJEoMqrwt14N5M7
    /sAoEQsvOwIAgs4e8VHndyYkHJmouEiqwFFBFY9aVG2L00tGgzzLaK+msMlLcPu7
    YiGcko8xy58Kui5x9M9WTNcAshBp/lc6J3rXSUSMu7fqqLuf6jqo0chijWLJUvzD
    g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBwFhQMtnLiAI99bByjeDLfxLfqysrkk6DA1aQRAH57Ke9F65Ut6qgBiTMc8J3+WPBFkOhixhOAIfoGz/OaE9xo0WJWMudNvkANZg88+fMKl4Mm+0vKw
    tppPzg7OkfCJpYzEXIHVobF46xc+kg/uCHDirBRvsz9MNN1TAcDFJHUNI+PhdozLyuPTpyRWMndzZPDVYDcUSlhog+PuYg+Nsw+vbLWgOg/z5APpT4CZRfxT
    0ObGsQXsdNyS/C/PQLuLKw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=fv-7OBe3yHGqfDU1zT0A:9 a=gt6zep4Hd1PL6YD3:21 a=tP4fx8xhwkWhgR2Y:21
    a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 76/76] staging: ks7010: Replace memcpy() with
 ether_addr_copy().
Date: Fri, 30 Mar 2018 00:08:42 -0700
Message-Id: <20180330070842.25224-79-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:qISa6GS48z5Y2t5axTLcXdpYRwXYXhn9DglcXNUsadriUg0a5hc
 Bxcr3Yu5QvFmg9IQsCNI/GtOuGzbPuQRzUN7fHVbSeWy8jPDnJRqh/bqoDkmZwucSh8dIKP
 L/VMaz/tNG2m8H8a93u4Iao198lUmt86Znz+Yu/BDSAigpir1asDtITkWYwRkNL7zPoraB9
 Eafi/0RjkXt0ZsO3nqzrw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U18kd8Dphp4=:dLH2yIlw7CDttU36Y1VNws
 aMA8PI9qRTsCr/QQTTPnNsu9QXD1yQveoe0l3a+UkApkwFW6wsDLYy7JTxbje5EB+zpi4K6mw
 sfV120k5zdtIG13+fdT62e44oIQ7CygGOPJQP+XD2WdT9YCQdtF1sBVB6warvyxm4Iv10tSzp
 LgspQqKubK/cv9Z071hhnlICRGvGojRK8x4l1LpeLtArAx+P8V8OmKzjOUJxN1JSCS71o/myR
 NiZhSjpYvmSB7vtN0Q5Fhcy77gfwsUWRca9pXNeIkn8gS0oVM1LuxeZrq+KC8S+ATej5+dhGu
 UQ8N0IniE1xIx4dmgpIzImbevfqBQiW5JfFSoICqYeDRkWlENhGqGlfGO5krOBMkYv5EzooOr
 3fS1OX/+I81DNPuPV1M5t3zI+TvNRNA4T2yBrMfXJx3p1lRakfaPGc+uekLse3pKVQpUQRaRJ
 YObgQq4Xj7TXmC5tCwE3zh7mzy+NnsXyC3cHYJQpOVThNRUZu+XSBrrAz+XO+sWTQGafV2Rx2
 ONiktdmbFkw9qfZqmOKGjyRTQQAumJeEga8wySc/OXcxoGzoB68PxtpnQibea4VTEze1W2wcV
 unNuJOF2gdfD9ujMk+lDr/HDBKIC77MdUfvDQeWzqvK72RGgF/qA9yaVx+YPeSDKYDEl6hax4
 Wc+6SX0PUDb4WgolLgpQLk5u4C+nxb0D0BNunwpJXDmiOzeaisO9pitzEr2z8nZnrpSZuPTOh
 +NlEdmYoVLBvfQbPrYhDWP7UhTk3DMkb+OACTw==
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
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ether_addr_copy() is the function for copying a hardware address,
so replace the manual memcpy() operation with ether_addr_copy().

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index fd1bf5d7ecd4..71cb366cb602 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -522,7 +522,7 @@ void hostif_mib_get_confirm(struct ks_wlan_private *priv)
 	case DOT11_MAC_ADDRESS:
 		/* MAC address */
 		hostif_sme_enqueue(priv, SME_GET_MAC_ADDRESS);
-		memcpy(dev->dev_addr, priv->rxp, ETH_ALEN);
+		ether_addr_copy(dev->dev_addr, priv->rxp);
 		priv->mac_address_valid = true;
 		netdev_info(dev, "MAC ADDRESS = %pM\n", dev->dev_addr);
 		break;
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
