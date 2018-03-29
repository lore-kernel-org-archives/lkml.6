Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbeC2Pe2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 11:34:28 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:39608 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbeC2Pe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 11:34:26 -0400
X-Google-Smtp-Source: AIpwx4/ziudrbo1jL5iF7voygOtKWWPnG7YXVoNRrzQQ6e7Mux/cnb0mrXy2npklzZ6K7eROimmCSnKBRXlKlTEeBeo=
MIME-Version: 1.0
In-Reply-To: <1522260676.12357.121.camel@perches.com>
References: <20180328175736.17360-1-rvarsha016@gmail.com> <1522260676.12357.121.camel@perches.com>
From: Varsha Rao <rvarsha016@gmail.com>
Date: Thu, 29 Mar 2018 21:03:45 +0530
Message-ID: <CAAFX7JTfWdaGra+kWBJt-GXVVO601K03qWnExFKFD_9vxS-03g@mail.gmail.com>
Subject: Re: [PATCH] crypto: cavium: zip: Remove unnecessary parentheses
To: Joe Perches <joe@perches.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, cocci <cocci@systeme.lip6.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 11:41 PM, Joe Perches wrote:
>
> On Wed, 2018-03-28 at 23:27, Varsha Rao wrote:
> > This patch fixes the clang warning of extraneous parentheses, with the
> > following coccinelle script.
> >
> > @@
> > identifier i;
> > constant c;
> > @@
> > (
> > -((i == c))
> > +i == c
> > >
> >
> > -((i <= c))
> > +i <= c
>
> Why just the "==" and "<=" cases?
> Why not "<", ">" and ">=" too?
>
> Why not expression instead of constant?

Initially I had the other cases too and used expression instead of
constant. But the results included only "==" and "<=" cases with
constant. Along with one false positive case.

--- a/drivers/crypto/cavium/zip/zip_main.c
+++ b/drivers/crypto/cavium/zip/zip_main.c
@@ -99,7 +99,7 @@ static struct zip_device *zip_alloc_devi
  */
 struct zip_device *zip_get_device(int node)
 {
-    if ((node < MAX_ZIP_DEVICES) && (node >= 0))
+    if (node < MAX_ZIP_DEVICES && node >= 0)
         return zip_dev[node];

     zip_err("ZIP device not found for node id %d\n", node);

I checked if there was any case of extra parentheses around relational
operators left, but there were none. Hence, in the script I included
only the cases present in the result.

Thanks,
Varsha
