Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FC9C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4708920C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4708920C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388151AbeGKQ7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:59:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:41563 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388003AbeGKQ7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:59:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 09:54:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,338,1526367600"; 
   d="scan'208";a="54274574"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2018 09:53:47 -0700
Subject: Re: [PATCH] i2c: aspeed: Add newline characters into message
 printings.
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko.nikula@linux.intel.com, james.feist@linux.intel.com,
        vernon.mauery@linux.intel.com
References: <20180702211359.30585-1-jae.hyun.yoo@linux.intel.com>
 <CAFd5g443wTQJ+0hrprOV949Sr_nRnBGpNo3Wd01xFN4GW4K2Ng@mail.gmail.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <2d2f2b2b-394a-506f-c870-33520335250b@linux.intel.com>
Date:   Wed, 11 Jul 2018 09:53:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g443wTQJ+0hrprOV949Sr_nRnBGpNo3Wd01xFN4GW4K2Ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/2018 10:42 PM, Brendan Higgins wrote:
> On Mon, Jul 2, 2018 at 2:14 PM Jae Hyun Yoo
> <jae.hyun.yoo@linux.intel.com> wrote:
>>
>> There are some log printing without a newline character. This
>> patch adds the missing newline characters.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> ---
>>   drivers/i2c/busses/i2c-aspeed.c | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
>> index 60e4d0e939a3..e3007c1c4ac5 100644
>> --- a/drivers/i2c/busses/i2c-aspeed.c
>> +++ b/drivers/i2c/busses/i2c-aspeed.c
>> @@ -407,7 +407,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>>           */
>>          ret = aspeed_i2c_is_irq_error(irq_status);
>>          if (ret < 0) {
>> -               dev_dbg(bus->dev, "received error interrupt: 0x%08x",
>> +               dev_dbg(bus->dev, "received error interrupt: 0x%08x\n",
>>                          irq_status);
>>                  bus->cmd_err = ret;
>>                  bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
>> @@ -416,7 +416,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>>
>>          /* We are in an invalid state; reset bus to a known state. */
>>          if (!bus->msgs) {
>> -               dev_err(bus->dev, "bus in unknown state");
>> +               dev_err(bus->dev, "bus in unknown state\n");
>>                  bus->cmd_err = -EIO;
>>                  if (bus->master_state != ASPEED_I2C_MASTER_STOP)
>>                          aspeed_i2c_do_stop(bus);
>> @@ -431,7 +431,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>>           */
>>          if (bus->master_state == ASPEED_I2C_MASTER_START) {
>>                  if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
>> -                       pr_devel("no slave present at %02x", msg->addr);
>> +                       pr_devel("no slave present at %02x\n", msg->addr);
> 
> Unless something changed in the last couple versions of the kernel, this is the
> only line that actually changes anything. dev_* inserts a newline for every
> call.
> 
> Admittedly, the rest of the file is pretty inconsistent, so if you really want
> to make all these changes, I don't feel super strongly about it.
> 

Agreed. Will drop this patch.

Thanks,

Jae

>>                          status_ack |= ASPEED_I2CD_INTR_TX_NAK;
>>                          bus->cmd_err = -ENXIO;
>>                          aspeed_i2c_do_stop(bus);
>> @@ -451,11 +451,11 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>>          switch (bus->master_state) {
>>          case ASPEED_I2C_MASTER_TX:
>>                  if (unlikely(irq_status & ASPEED_I2CD_INTR_TX_NAK)) {
>> -                       dev_dbg(bus->dev, "slave NACKed TX");
>> +                       dev_dbg(bus->dev, "slave NACKed TX\n");
>>                          status_ack |= ASPEED_I2CD_INTR_TX_NAK;
>>                          goto error_and_stop;
>>                  } else if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
>> -                       dev_err(bus->dev, "slave failed to ACK TX");
>> +                       dev_err(bus->dev, "slave failed to ACK TX\n");
>>                          goto error_and_stop;
>>                  }
>>                  status_ack |= ASPEED_I2CD_INTR_TX_ACK;
>> @@ -478,7 +478,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>>                  /* fallthrough intended */
>>          case ASPEED_I2C_MASTER_RX:
>>                  if (unlikely(!(irq_status & ASPEED_I2CD_INTR_RX_DONE))) {
>> -                       dev_err(bus->dev, "master failed to RX");
>> +                       dev_err(bus->dev, "master failed to RX\n");
>>                          goto error_and_stop;
>>                  }
>>                  status_ack |= ASPEED_I2CD_INTR_RX_DONE;
>> @@ -509,7 +509,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>>                  goto out_no_complete;
>>          case ASPEED_I2C_MASTER_STOP:
>>                  if (unlikely(!(irq_status & ASPEED_I2CD_INTR_NORMAL_STOP))) {
>> -                       dev_err(bus->dev, "master failed to STOP");
>> +                       dev_err(bus->dev, "master failed to STOP\n");
>>                          bus->cmd_err = -EIO;
>>                          /* Do not STOP as we have already tried. */
>>                  } else {
>> @@ -520,7 +520,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>>                  goto out_complete;
>>          case ASPEED_I2C_MASTER_INACTIVE:
>>                  dev_err(bus->dev,
>> -                       "master received interrupt 0x%08x, but is inactive",
>> +                       "master received interrupt 0x%08x, but is inactive\n",
>>                          irq_status);
>>                  bus->cmd_err = -EIO;
>>                  /* Do not STOP as we should be inactive. */
>> @@ -851,7 +851,7 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
>>          bus->rst = devm_reset_control_get_shared(&pdev->dev, NULL);
>>          if (IS_ERR(bus->rst)) {
>>                  dev_err(&pdev->dev,
>> -                       "missing or invalid reset controller device tree entry");
>> +                       "missing or invalid reset controller device tree entry\n");
>>                  return PTR_ERR(bus->rst);
>>          }
>>          reset_control_deassert(bus->rst);
>> --
>> 2.17.1
>>
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 
