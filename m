Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423ABC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AA026889
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AA026889
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753379AbeF1EMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:12:37 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:33292 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbeF1EMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:12:34 -0400
Received: by mail-qt0-f181.google.com with SMTP id l10-v6so3633470qtj.0;
        Wed, 27 Jun 2018 21:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=FcyLcZW4/T6IGX7pMbswQ4WwGic9hwaq4a6s3YaMnv0=;
        b=nf/A81mjZjmFt9CN00EA8OC5rQ10q9meENrB92ieziMfmtCD6/yJ0RGOQ/7NtEEIXD
         w7wtywPdJhHtyJyGXHTo0jEUgw81TzfJs7PT/nrAzxzaZyjjGoqztUkBPNjgzplgxhee
         M91YG4fgd4onq6I238hmVfKsYFFdbHvBagPWJF74oTEK4RH9u2M2wN50y/tHZstoHAIw
         OUFGluDrXTGLGk7s8mmUVe+dKOO207VJpB/lN/eYiXLbFJp/IPOCTTO0A4h2uXBq01Aw
         zKKAVrvWr3OOeZyNR72z0JYfBI8TjIwVUgPu6y0kYlEY454WYwtllTFcWeAGAE+nmlTs
         UsJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=FcyLcZW4/T6IGX7pMbswQ4WwGic9hwaq4a6s3YaMnv0=;
        b=cniQVoSJwV1yuhBdmP8VySSdhsLCEfXmuF46NCZ/CJn5b58cHig4AxnQH0HTEHAagA
         42VzvDz2XsEUOTswxVKKuVdAqoCSflCR0x0+Cs5RFspgJQYR0VVrpgat3z7mDUnkC3/l
         Td6QM2osbUFe7s4+QZ1NCpIjo4wSX/ypJlYqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=FcyLcZW4/T6IGX7pMbswQ4WwGic9hwaq4a6s3YaMnv0=;
        b=S0iwE0d9+oLsJMNBBLzKyn9+zIxDdYykKcPwn9IYeMOJHuGp2qeBeOkPL/OoEiOSsM
         iAchfIj9qVZYqg+og0x7AzCqsL+V0ZRG9KuEdCMOQsxX6dV8P3L8k4/zZK2b5OOmHGOz
         1SlY1XZncAPuBvgCWMLB8WMOIxpiVy6t2gmKUcNNsp4OCbjGdvT5jVMr5PDLdbULulAz
         IN2SYy/AtfTx5mAaMWGjqSTl4zTivgkRlF9WCao2qqlKvovHBMSbTP/aUi8a9qceW7OJ
         s/cbH8FPe/a+Qen6N7OG5vEhSxArhJuSL5leAHW6nTgmHozPvAW1i+mhsowj8bU48CYy
         82zA==
X-Gm-Message-State: APt69E1QFl4IYGbq3KeFtG3ujHczUTrPD/VwiIpGJI99wAbJIBCjR+N5
        j7e+FuU4Ljm6HIY6CoNkdTScy9Ku/Hso0llnjQ4=
X-Google-Smtp-Source: AAOMgpe8BZ37LXT8LzMOtzBjrl+7sqAsgUZ7b2SBtzJbw5XIE2JoVEoVotbHbjVVfBUf2irQh3MRTBDlCDcPb6F94uk=
X-Received: by 2002:a0c:9b93:: with SMTP id o19-v6mr7873993qve.89.1530159153653;
 Wed, 27 Jun 2018 21:12:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:169d:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 21:12:13
 -0700 (PDT)
In-Reply-To: <20180626232605.13420-11-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org> <20180626232605.13420-11-benh@kernel.crashing.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 28 Jun 2018 13:42:13 +0930
X-Google-Sender-Auth: MekCtuqhv1P6kvLe-wfes2C_BKU
Message-ID: <CACPK8XeAg8v-9-PX0wxP7tK5Eb3JrgdPUYaOpRPnzEwtW0BfXA@mail.gmail.com>
Subject: Re: [PATCH 10/14] fsi: Move various master definitions to a common header
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-aspeed@lists.ozlabs.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 June 2018 at 08:56, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> This moves the definitions for various protocol details
> (message & response codes, delays etc...) out of
> fsi-master-gpio.c to fsi-master.h in order to share them
> with other master implementations.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
