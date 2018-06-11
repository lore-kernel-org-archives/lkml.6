Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9Wg8IAJ7HluRQwAAmS7hNA
	; Mon, 11 Jun 2018 13:38:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A29CB607E4; Mon, 11 Jun 2018 13:38:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3759860541;
	Mon, 11 Jun 2018 13:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3759860541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933326AbeFKNiU convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 19 others);
        Mon, 11 Jun 2018 09:38:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54303 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932917AbeFKNiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:38:18 -0400
Received: from marcel-macpro.fritz.box (p5B3D24B5.dip0.t-ipconnect.de [91.61.36.181])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3E16ACF185;
        Mon, 11 Jun 2018 15:44:59 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v2 21/24] rave-sp: Support for variants on modalias
 drivers
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHp75VeeF4eNjyhhBxocRXboN3fRY=RjrT6QQ72=QJ-s8gvSfA@mail.gmail.com>
Date: Mon, 11 Jun 2018 15:38:16 +0200
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <8912BE88-4AA3-44ED-9828-57666CB31522@holtmann.org>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-22-ricardo.ribalda@gmail.com>
 <CAHp75VeeF4eNjyhhBxocRXboN3fRY=RjrT6QQ72=QJ-s8gvSfA@mail.gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

>> Rave-sp behaves differently based on the device variant.
> 
> 
>>        sp->variant = of_device_get_match_data(dev);
>> +       if (!sp->variant) {
>> +               id = serdev_match_id(rave_sp_serdev_id, serdev);
> 
> I think you may leave the ID table where it is in the code and use link.
> 
>> +               if (id)
>> +                       sp->variant = (const struct rave_sp_variant *)
>> +                                                       id->driver_data;
>> +       }
> 
> Perhaps a helper like it's done for ACPI / OF cases?
> 
> [device_get_match_data() -> ]
>  of_fwnode_device_get_match_data()
>  acpi_fwnode_device_get_match_data()

something like that and frankly this is trying to hard. This driver is currently really DT specific and can be fixed up later. It is causing a lot of noise in this patch series. I would really urge to focus on the core changes get prominent drivers support. I think hci_bcm.c is a good example since a) we need to fix up Edison and b) new ACPI based tablets might be able to allow for easy testing.

Regards

Marcel
