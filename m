Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E784C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F25248E9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="A5kUABm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F25248E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933504AbeFVVNv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:13:51 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43390 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932950AbeFVVNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:13:49 -0400
Received: by mail-pf0-f196.google.com with SMTP id y8-v6so3752570pfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 14:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2O/Hks8r4FML/G6fteIjRZr6efMspbWXGAc7fnRdUVk=;
        b=A5kUABm9Z72FARK+0bx39oP24VqWo4CGI6wWrpVGe+fLHwJp26jk3GvWkky/No3OBR
         dBp6ogJeKHGFp9lb1v2yd68eiGFE5n7+NZbSQPZAz1fT7tgbMyW2ypBaFX+kxl+x00ZY
         a4of7Zf3HPNBWcz2RO+1yjpLHfrsJBwygFLElxsUBpsoSNvroLib9ga6Qrp7et8/5vMS
         7Y3ldCGrN3f4xqda0SdthyjAvkYknGLc5wcNWseFYgqUTc4+m6uqamZSSCEZKmfsQ3vB
         fX6D3XXFZ83i9fsOYN+oatcfhGzUrpPPjqW5mii6VhfhaZQC4m8gAiYfgu6paT5YOWr0
         pJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2O/Hks8r4FML/G6fteIjRZr6efMspbWXGAc7fnRdUVk=;
        b=HKo3LpU5319Tgk39keQz9ac68wPpBml+gvR9CtrguPM7E8R68XTQn9AIPX9J6//WvL
         JOL21Q7cyTF8f9IZXNa3/QGCFIX7rT0cUPbXqd2F+frcCz5R8dO7XTk2MM9LtXpd11pV
         0+GXgGKDkur4EAJFHLm4vnQmmA5qIWem2OESJqk1h/BILYG8LxIJBSHjbTWpaV1uhnZF
         0b6Q3edDXMYWaRqhzQHj6UdsFoycz3ISZHEa2SZcXF06VsLv/3irO7JPjXySwEpV6/Sf
         Z/B0EHDj9QgBZMHObswYw/Qnaft775YRrrmvlPnmCnI7EnPhVrefH7P7cTZdMSSHEj6J
         08UQ==
X-Gm-Message-State: APt69E0IaoofnofBqBAoL93qacweIp2BJrkjWOZD9m8R8i+2aRyMUDG/
        +Hdtqpdng9n26B9aQzmZ+9dE9Z1pnU4=
X-Google-Smtp-Source: ADUXVKIrQHZlA2kSkxZ+kYquY0YE98obFldn9X7nMD4Rx+ScRqNmljZP8d6k8KmpGxsKr2Uizz7Xnw==
X-Received: by 2002:a65:444f:: with SMTP id e15-v6mr1138255pgq.348.1529702028748;
        Fri, 22 Jun 2018 14:13:48 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id t68-v6sm14554420pfe.91.2018.06.22.14.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 14:13:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fWTNK-00024z-16; Fri, 22 Jun 2018 15:13:46 -0600
Date:   Fri, 22 Jun 2018 15:13:46 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] tpm: Implement tpm_chip_find() for other
 subsystems to find a TPM chip
Message-ID: <20180622211346.GF19151@ziepe.ca>
References: <20180622164613.1609313-1-stefanb@linux.vnet.ibm.com>
 <20180622164613.1609313-3-stefanb@linux.vnet.ibm.com>
 <20180622204319.GE19151@ziepe.ca>
 <6f4d9302-8399-e73a-f8d0-d493658c1980@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f4d9302-8399-e73a-f8d0-d493658c1980@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 04:45:47PM -0400, Stefan Berger wrote:
> On 06/22/2018 04:43 PM, Jason Gunthorpe wrote:
> >On Fri, Jun 22, 2018 at 12:46:11PM -0400, Stefan Berger wrote:
> >>Implement tpm_chip_find() for other subsystems to find a TPM chip and
> >>get a reference to that chip.
> >>
> >>Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >>  drivers/char/tpm/tpm-chip.c | 27 +++++++++++++++++++++++++++
> >>  include/linux/tpm.h         |  5 +++++
> >>  2 files changed, 32 insertions(+)
> >>
> >>diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> >>index 4e83695af068..2520555b1e17 100644
> >>+++ b/drivers/char/tpm/tpm-chip.c
> >>@@ -81,6 +81,33 @@ void tpm_put_ops(struct tpm_chip *chip)
> >>  EXPORT_SYMBOL_GPL(tpm_put_ops);
> >>  /**
> >>+ * tpm_chip_find() - find a TPM chip and get a reference to it
> >>+ */
> >>+struct tpm_chip *tpm_chip_find(void)
> >I feel like this should be called 'tpm_default_chip()'
> >
> >>+{
> >>+	struct tpm_chip *chip, *res = NULL;
> >>+	int chip_num = 0;
> >>+	int chip_prev;
> >>+
> >>+	mutex_lock(&idr_lock);
> >>+
> >>+	do {
> >>+		chip_prev = chip_num;
> >>+		chip = idr_get_next(&dev_nums_idr, &chip_num);
> >>+		if (chip) {
> >>+			get_device(&chip->dev);
> >>+			res = chip;
> >>+			break;
> >>+		}
> >>+	} while (chip_prev != chip_num);
> >>+
> >>+	mutex_unlock(&idr_lock);
> >And what was tpm_chip_find_get should just call this function..
> And then after that each time tpm_get_ops() ?

It is best to keep the tpm_chip_find_get/tpm_put_ops for internal use
as it also manages the kref lifetime of chip in a subtle way, it
relies on the ops lock not the kref to keep the memory valid when it
has a NULL parameter..

Something like this:

struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip)
{
    int rc;

    if (chip) {
          if (!tpm_try_get_ops(chip))
	      return NULL;
	  return chip;
    }

    chip = tpm_default_chip();
    rc = tpm_try_get_ops(chip));
    put_device(&chip->dev);

    if (rc)
           return NULL;
    return chip;
}

Jason
