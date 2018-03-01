Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3347819-1519921453-2-14511304196516834851
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519921453; b=PqKNJst3tNBV4uLqZLiUl9st3V1407pzvIdPMp3su92S/DV
    7ORTqRgU27M64UZ7cQB/+tAyFi9E6cACjjssywdsIMNb67RpYE8MkqzY80/pARYM
    W4cRV3cQn890aUmaNdSgAmj5dxNHELPwlc3wP7JK+1rwBDS8zuc3OXvFCz00OuHA
    sbNMuaKdjHktAQCgecBTEHebXmdkyZPEJnnh2rc7hy94OR3+AK6NhF47XDYL2sWc
    8Sad5iVordOqJwU+jQ2kbDQlnUhF6LIRafMaJJ2Whuk831vsFtRYXtgDOqI+bBNU
    n2/nij21Ug6GXrk5F/qBmMKMUNTevE9c+xtnYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519921453; bh=d
    aiKcq4BqmIMW5I7XAWozHyNv93HnujKSmKucwljQjo=; b=jsqsBWllvCjqUQvs2
    NX/d0YQXd0jumtOopj0HU54hbcsNFgKs8h8zJFq9AazlkIU4WqOVNE6Z6iTcrPqq
    kuXtzxYgqtaayOxVZVPEuord1QKCqgTKFmtAoVm2mZgT6BsP9MW4uxDAS486i41I
    Q8PkCV4MOOq0mC36Vo8N4UwkgoscPnV+zykoxBPW6OYqKezI/+UcluNgPiL64lsG
    Jvx/dpXUds8FvQY6tjMwdTcQIgsNB9mjMeQZPfDjupyXgjFrQomHzniSWwunuf5j
    JaR4NdyRccNZ8Mt3Ola0bD9JoTsTN/uJggkiBRWkIpH8Jqi2JYjdxNrLoXHFYhSF
    Q0elw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=jVFzvM77 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ss79hr/M;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=jVFzvM77 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ss79hr/M;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELv5V6S3RR0l9HR8Ycg2G1ww8L8fxCN/UMd+VyFdOfDUOtATNlT0nrQy68aY0nCRNIfMKA+Znt/g02zI0H8TvBA=
MIME-Version: 1.0
In-Reply-To: <CAOMZO5B_UGZ3De1UjUXzU6-wGMgRrRJVWZ8z+a+HoCpwWkeBwg@mail.gmail.com>
References: <20180301040939.GA13274@embeddedgus>
 <CAOMZO5B_UGZ3De1UjUXzU6-wGMgRrRJVWZ8z+a+HoCpwWkeBwg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 1 Mar 2018 13:24:03 -0300
Message-ID: <CAOMZO5A9KazX=NiaH6Px+=KsBSb2rHrdehtkzXgVFa5gTPjSwg@mail.gmail.com>
Subject: Re: [PATCH] staging/imx: Fix inconsistent IS_ERR and PTR_ERR
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Steve Longerbeam <slongerbeam@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Steve, Phiipp,

On Thu, Mar 1, 2018 at 1:02 PM, Fabio Estevam <festevam@gmail.com> wrote:

> So imx_csi_probe() does not succeed anymore since
> devm_pinctrl_get_select_default() always fails.
>
> Not sure I understand the comments that explain the need for pinctrl
> handling inside the driver.
>
> Can't we just get rid of it like this?

Just tested and if devm_pinctrl_get_select_default() is removed, I am
not able to change the ipu csi pinctrl settings anymore.

I had to ignore devm_pinctrl_get_select_default() error value so that
the driver can probe again:

diff --git a/drivers/staging/media/imx/imx-media-csi.c
b/drivers/staging/media/imx/imx-media-csi.c
index 5a195f8..c40f786 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1797,11 +1797,8 @@ static int imx_csi_probe(struct platform_device *pdev)
         */
        priv->dev->of_node = pdata->of_node;
        pinctrl = devm_pinctrl_get_select_default(priv->dev);
-       if (IS_ERR(pinctrl)) {
-               ret = PTR_ERR(priv->vdev);
-               goto free;
-       }
-
+       if (IS_ERR(pinctrl))
+               dev_dbg(priv->dev, "pintrl_get_select_default() failed\n");
        ret = v4l2_async_register_subdev(&priv->sd);
        if (ret)
                goto free;

Is there a better solution for this issue?
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
