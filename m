Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB837C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D07E21566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SsZ6IxGp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Zq3h8lpe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D07E21566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbeHBUEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 16:04:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49492 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729733AbeHBUEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 16:04:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9BFCF60B11; Thu,  2 Aug 2018 18:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533233559;
        bh=YvTxDYgYRXbrK3/H22AFUimiwI3Ub3ZsYbThp9hnn9Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SsZ6IxGppNcgDpQXqnlZ+tKmU+S7MHNT5TtlaQQdsCfjCLRHrVlp6QYm+hI4MrFiZ
         E5O5Tnu8TSkhe7nYfhLTNMhnnPNaLKvF9OAYF+5YwsU4HRVvml4ALDeSUDoBIKVKa6
         ActB4Q48zuWF2StvDD48REyr9AlU6UKBppc4nKbg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 897D1602D7;
        Thu,  2 Aug 2018 18:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533233558;
        bh=YvTxDYgYRXbrK3/H22AFUimiwI3Ub3ZsYbThp9hnn9Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zq3h8lpe3wUzwU37dsfWX5oatIwoVg81utPyrtufnaVfM96IXdwyJ7/q9c0mAaOY4
         J+12lAER/iQnAP7POta4DuNLkQjwWvoz7rc1hGf6jAevPlFg7iKxGCV1ZdH+D1b0Xi
         ndsPqky03ik6G4EUOyYMUmRbu6nIF9a6Qo9j+GD8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Aug 2018 23:42:38 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v12 1/7] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip wcn3990
In-Reply-To: <20180802181038.GO68975@google.com>
References: <20180802132518.8680-1-bgodavar@codeaurora.org>
 <20180802132518.8680-2-bgodavar@codeaurora.org>
 <20180802172043.GN68975@google.com>
 <366e23679cabb332b1ecde8396570f66@codeaurora.org>
 <58791a55af5532d476febddea6756fdb@codeaurora.org>
 <20180802181038.GO68975@google.com>
Message-ID: <63b7e37b2ee523862c64526aae89a239@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-08-02 23:40, Matthias Kaehlcke wrote:
> On Thu, Aug 02, 2018 at 11:35:54PM +0530, Balakrishna Godavarthi wrote:
>> Hi Matthias,
>> 
>> On 2018-08-02 23:24, Balakrishna Godavarthi wrote:
>> > Hi Matthias,
>> >
>> > On 2018-08-02 22:50, Matthias Kaehlcke wrote:
>> > > On Thu, Aug 02, 2018 at 06:55:12PM +0530, Balakrishna Godavarthi
>> > > wrote:
>> > > > This patch enables regulators for the Qualcomm Bluetooth wcn3990
>> > > > controller.
>> > > >
>> > > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> > > > Reviewed-by: Rob Herring <robh@kernel.org>
>> > > > ---
>> > > >  .../bindings/net/qualcomm-bluetooth.txt       | 26
>> > > > +++++++++++++++++--
>> > > >  1 file changed, 24 insertions(+), 2 deletions(-)
>> > > >
>> > > > diff --git
>> > > > a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> > > > b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> > > > index 0ea18a53cc29..2175174415ee 100644
>> > > > --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> > > > +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> > > > @@ -10,12 +10,22 @@ device the slave device is attached to.
>> > > >  Required properties:
>> > > >   - compatible: should contain one of the following:
>> > > >     * "qcom,qca6174-bt"
>> > > > +   * "qcom,wcn3990-bt"
>> > > > +
>> > > > +Optional properties for compatible string qcom,qca6174-bt:
>> > > >
>> > > > -Optional properties:
>> > > >   - enable-gpios: gpio specifier used to enable chip
>> > > >   - clocks: clock provided to the controller (SUSCLK_32KHZ)
>> > > >
>> > > > -Example:
>> > > > +Optional properties for compatible string qcom,wcn3990-bt:
>> > > > +
>> > > > + - vddio-supply: Bluetooth wcn3990 VDD_IO supply regulator handle.
>> > > > + - vddxo-supply: Bluetooth wcn3990 VDD_XO supply regulator handle.
>> > > > + - vddrf-supply: Bluetooth wcn3990 VDD_RF supply regulator handle.
>> > > > + - vddch0-supply: Bluetooth wcn3990 VDD_CH0 supply regulator handle.
>> > >
>> > > Are these really optional? If I understand correctly the driver
>> > > expects the regulators to be there. Even if it could do with only some
>> > > regulators specified the devm_regulator_bulk_get() call would fail if
>> > > not all requested regulators are available.
>> >
>> > yes they are required along with compatible string "qcom,wcn3990-bt".
>> > i have taken reference wrt compatible string "qcom,qca6174-bt".
>> > In which clocks and enable-gpios are required for driver to work, but
>> > it was written as optional in doc.
>> >
>> > below snippet from hci_qca.c for qcom,qca6174-bt.
>> >
>> >  if (IS_ERR(qcadev->bt_en)) {
>> >        dev_err(&serdev->dev, "failed to acquire enable gpio\n");
>> >        return PTR_ERR(qcadev->bt_en);
>> >     }
>> >
>> >   qcadev->susclk = devm_clk_get(&serdev->dev, NULL);
>> >   if (IS_ERR(qcadev->susclk)) {
>> >       dev_err(&serdev->dev, "failed to acquire clk\n");
>> >        return PTR_ERR(qcadev->susclk);
>> >      }
>> 
>> technically it is not correct then i will update as below
>> 
>> Required properties for compatible string qcom,wcn3990-bt:
>> 
>>  - vddio-supply: Bluetooth wcn3990 VDD_IO supply regulator handle.
>>  - vddxo-supply: Bluetooth wcn3990 VDD_XO supply regulator handle.
>>  - vddrf-supply: Bluetooth wcn3990 VDD_RF supply regulator handle.
>>  - vddch0-supply: Bluetooth wcn3990 VDD_CH0 supply regulator handle.
>> 
>> Optional properties for compatible string qcom,wcn3990-bt:
>> 
>>  - max-speed: see 
>> Documentation/devicetree/bindings/serial/slave-device.txt
>> 
>> are they above ok?
> 
> 
> Looks good to me.
> 
> Optionally you could remove the 'Bluetooth wcn3990' part in the
> regulator description, it is a bit redundant since it's already said
> that these are properties for the 'Bluetooth wcn3990' compatible
> string.


Ok. will update the same.

-- 
Regards
Balakrishna.
