Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753869AbeEHBwp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 21:52:45 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45509 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753807AbeEHBwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 21:52:43 -0400
X-Google-Smtp-Source: AB8JxZq9lyh7LPCAuDYhyC0nwnCR6T1z/t+fxbIpk+2yvg5eBNRs7cinn6p9r0YiK0iyfV0UGs+J/kGXU+p0dXVXpxY=
MIME-Version: 1.0
In-Reply-To: <db2df5f2-994b-066a-3edf-e9848356cecd@gmail.com>
References: <099f4075ec489e425b5f1e7668a078c05f0d8509.1525427961.git.baolin.wang@linaro.org>
 <db2df5f2-994b-066a-3edf-e9848356cecd@gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Tue, 8 May 2018 09:52:42 +0800
Message-ID: <CAMz4ku+fofZbE7G0UrxKceDMXZUXvex-hqVOXc_1Am6dqb+wQA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: leds: Add SC27xx breathing light
 controller documentation
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, xiaotong.lu@spreadtrum.com,
        Mark Brown <broonie@kernel.org>, linux-leds@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On 8 May 2018 at 04:13, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
> Hi Baolin,
>
> Thank you for the patch. Please find few notes below.
>
> On 05/04/2018 12:08 PM, Baolin Wang wrote:
>>
>> This patch adds the binding documentation for Spreadtrum SC27xx series
>> breathing light controller, which supports 3 outputs: red LED, green
>> LED and blue LED.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>   .../devicetree/bindings/leds/leds-sc27xx-bltc.txt  |   39
>> ++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
>> b/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
>> new file mode 100644
>> index 0000000..d4e267d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
>> @@ -0,0 +1,39 @@
>> +LEDs connected to Spreadtrum SC27XX PMIC breathing light controller
>> +
>> +The SC27xx breathing light controller supports to 3 outputs:
>> +red LED, green LED and blue LED. Each LED can work at normal
>> +PWM mode or breath light mode.
>> +
>> +Required properties:
>> +- compatible: should be "sprd,sc27xx-bltc".
>
>
> s/should/Should/

OK.

>
>> +- #address-cells: must be 1.
>
>
> s/must/Must/

OK.

>
>> +- #size-cells: must be 0.
>
>
> Ditto.
>
>> +- reg: specify controller address.
>
>
> s/specify/Specify/

OK.

>
>> +
>> +LED sub-node properties:
>> +- reg: number of LED line (could be from 0 to 2).
>
>
> s/number/Number/

OK.

>
>> +- label: (optional) name of LED.
>
>
> - label: see Documentation/devicetree/bindings/leds/common.txt

OK.

>
>
>> +
>> +Examples:
>> +
>> +led-controller@200 {
>> +       compatible = "sprd,sc27xx-bltc";
>> +       #address-cells = <1>;
>> +       #size-cells = <0>;
>> +       reg = <0x200>;
>> +
>> +       red@0 {
>
>
> s/red/led/
>
>> +               label = "red";
>> +               reg = <0x0>;
>> +       };
>> +
>> +       green@1 {
>
>
> s/green/led/
>
>> +               label = "green";
>> +               reg = <0x1>;
>> +       };
>> +
>> +       blue@2 {
>
>
> s/blue/led/

Will change the node name. Thanks for your comments.

-- 
Baolin.wang
Best Regards
