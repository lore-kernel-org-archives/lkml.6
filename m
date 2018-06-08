Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +ZWPJO/PGlu1EAAAmS7hNA
	; Fri, 08 Jun 2018 18:54:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0E5FE607E4; Fri,  8 Jun 2018 18:54:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZ0XAKH1"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,FSL_HELO_FAKE,MAILING_LIST_MULTI
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8FB06601D2;
	Fri,  8 Jun 2018 18:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8FB06601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752979AbeFHSyv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:54:51 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44264 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752478AbeFHSys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:54:48 -0400
Received: by mail-lf0-f68.google.com with SMTP id 36-v6so21504697lfr.11;
        Fri, 08 Jun 2018 11:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OaSdBIqYBHBRB+LLQmqGcOTxPsdyyIFuRWAY1y75tbY=;
        b=qZ0XAKH1hSGynsgQ9oWV4fGgKw9Dqb05raEY6MkGqOFN4wM/9QZKFmIvm7a2P7rz7K
         TeV4eWowGfBksgab9Ebv81FlQdSzx0jnvV0TgsQUJG8oUOmZnPa6r30f42JEDXfEWr4X
         X+9dC7AmNhzSMv/wdmLAkhHWIM9uJFg3akXHqEQ6Np8PN47j4oc0RtJdrK7iWJG+ES+9
         GuNUUo8GLkuDMK6Ig8GrUiIzyUPOln2xH1bu8cDKuz38iCs2QlwLnQm3mzLCRORJKB96
         LZLIMWOGawmECCjuKrx+XaSfg/iNwQTkx7EcGvPWv/+MbtLXyJ3s4cjt+WPfY0jMEeCD
         Y9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OaSdBIqYBHBRB+LLQmqGcOTxPsdyyIFuRWAY1y75tbY=;
        b=ImGGQTUn1k9ByYZ0RkQalTbKwO0Q197uCes5Rf6y5YAmcvsKO1IfUtq2Tdl/9pdC63
         9SVVClWwA7lPrY6Sy9xSbDuTH8u3Mt8/oDsq/PC5pW0aeTMps1koARKSDdWl5GcA5Rbl
         Td+SpfseBXnHkm35KJqzefMmC/4h42W+gDogqbedRctjbc6cjgFw53B7GI0x7ex3PQM2
         1+FFNYJKh38DfkeW1c0RSzotJma1sMt+GpJhpSrW2Rn/WUtBIvO/E/zvIKzYh7a9ulYI
         Lr3eyk2DUaORZ2BHMqbVkc1X8eaqpEne1J5MtVk7PQ2YkX/RMHv1lf/K/zs1Vs7H4YXD
         mMPw==
X-Gm-Message-State: APt69E0X7KDJCallaIaGGgbt9km4tReUhJq9sJfKrxMPIbveHeW7T1x8
        FN7SNW0gGv3vtYlMsDF53vI=
X-Google-Smtp-Source: ADUXVKIgrzOGZHrN7NX/tWlr8LJak75ZbWXJMO07DVRJvmqjrXsBbyOpYUuObXCVTCHNoWpffI78sQ==
X-Received: by 2002:a2e:8682:: with SMTP id l2-v6mr5607470lji.48.1528484086947;
        Fri, 08 Jun 2018 11:54:46 -0700 (PDT)
Received: from gmail.com ([46.194.229.154])
        by smtp.gmail.com with ESMTPSA id e16-v6sm2719230lfi.70.2018.06.08.11.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 11:54:46 -0700 (PDT)
Date: Fri, 8 Jun 2018 20:54:43 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, davem@davemloft.net,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] usb: gadget: ccid: add support for USB CCID
 Gadget Device
Message-ID: <20180608185443.GB874@gmail.com>
References: <20180529185021.13738-1-marcus.folkesson@gmail.com>
 <87r2ltcopp.fsf@linux.intel.com>
 <20180530140415.GE2939@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530140415.GE2939@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

Should I send out v4 or what do you think?

On Wed, May 30, 2018 at 04:04:15PM +0200, Marcus Folkesson wrote:
> Hi Filipe,
> 
> On Wed, May 30, 2018 at 03:28:18PM +0300, Felipe Balbi wrote:
> > Marcus Folkesson <marcus.folkesson@gmail.com> writes:
> > 
> > > Chip Card Interface Device (CCID) protocol is a USB protocol that
> > > allows a smartcard device to be connected to a computer via a card
> > > reader using a standard USB interface, without the need for each manufacturer
> > > of smartcards to provide its own reader or protocol.
> > >
> > > This gadget driver makes Linux show up as a CCID device to the host and let a
> > > userspace daemon act as the smartcard.
> > >
> > > This is useful when the Linux gadget itself should act as a cryptographic
> > > device or forward APDUs to an embedded smartcard device.
> > >
> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > 
> > this could be done entirely in userspace with functionfs, why do we need
> > this part in the kernel? It does very little.
> 
> Andrzej pointed this out, and I actually do not have any good answer
> more than that the userspace application could be kept small and the
> important configuration of the CCID device is done with well (I hope)
> documented configfs attributes.
> 
> > 
> > -- 
> > balbi
> 
> Best regards,
> Marcus Folkesson
> 
> 

Thank you,
Marcus Folkesson
