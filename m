Return-Path: <robh@kernel.org>
X-Google-Smtp-Source: AIpwx4+VT/grCW+Dr99VphV9dfkbZ3TVcYnDPW9+s9YtLO3nLbhGS4YCkjJ72jGK0dDLQk6urlro
ARC-Seal: i=1; a=rsa-sha256; t=1524086228; cv=none;
        d=google.com; s=arc-20160816;
        b=euCKEZqMpdzMHZadTkAbtxzZP/0Vm6TpbaBcg+nLP1I87cSVeYRzhoedNzCOkuxdVj
         sYSu0gC7kYcZc72c9gZASb7PGIljSmcWC2x7XRp4aIytfmFjYQf9CaDX0obw8KuO1HXN
         nrvzIOyH7svIe7PE+Vs/yppKekSEo8n/NXHxumb0dZENKZ9Pb940aPyzS7+H65ZW8crw
         42fw+Szh5Z74g3z+mk6sSoIsOzH1FtH28uKLlO2mw1O336iKNGzacxiK1+p7Xb6clhsc
         l1/IzTy16EsmEcsG8DTfHWkm5nS9eVY4aGPn9dm704LQ1t9NoKK89nObX+wMygcomEDd
         po5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=hxFw3YmmLKJ/VQLUFS6P2PSMdzXClWsoGueEinakgpo=;
        b=jUqg3Ot1Q/lQDr3TM6vw2+x67BS8aKFzlH9Nxn5KxapeGciHWXqXObLfxCvppNcWxY
         zVMRlKHzxAG6MfoV4sdvHVQC/kG1YeovHfCUHN2XXlN/0vwaWQCpXfoGeeulttaL+Hhq
         TykgacvlLCHmnubh4rkwHbevQmPn4OrdFUWDPZcDMTjZ2GLTY3niRPlFuUvJ6NJhOWVb
         l8kYPOLyZbPjoPsPgWu+5oltlviExAXFxwZpWN3pDQFAcoYr9t54/n3Qmu1smA1dY1xq
         rlC5rd9pRpiQfIlx30VX0j3KW6qQS7qVnw33Hsd4HnUMyxLV+KPB0EgnM6e5nB95z2YF
         VsiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F80A217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180415125528.GA15803@arch.home>
References: <20180407135934.26122-1-ctatlor97@gmail.com> <20180407175802.29444-1-ctatlor97@gmail.com>
 <20180407175802.29444-2-ctatlor97@gmail.com> <20180413163527.ludqnnc5nkj4spre@rob-hp-laptop>
 <20180415125528.GA15803@arch.home>
From: Rob Herring <robh@kernel.org>
Date: Wed, 18 Apr 2018 16:16:46 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKKn_GH90kq+JrtRraRkZLvAO0Xd5J3zCWkQWxPv3Akog@mail.gmail.com>
Message-ID: <CAL_JsqKKn_GH90kq+JrtRraRkZLvAO0Xd5J3zCWkQWxPv3Akog@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: power: supply: qcom_bms: Add bindings
To: Craig Tatlor <ctatlor97@gmail.com>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597095394982255487?=
X-GMAIL-MSGID: =?utf-8?q?1598120241266263664?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 15, 2018 at 7:55 AM, Craig Tatlor <ctatlor97@gmail.com> wrote:
> On Fri, Apr 13, 2018 at 11:35:27AM -0500, Rob Herring wrote:
>> On Sat, Apr 07, 2018 at 06:57:45PM +0100, Craig Tatlor wrote:
>> > Add bindings for the Qualcomm Battery Monitoring system.
>> >
>> > Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
>> > ---
>> >  .../bindings/power/supply/qcom_bms.txt        | 93 +++++++++++++++++++
>> >  1 file changed, 93 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/power/supply/qcom_bms.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/power/supply/qcom_bms.txt b/Documentation/devicetree/bindings/power/supply/qcom_bms.txt
>> > new file mode 100644
>> > index 000000000000..6296399edc09
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/power/supply/qcom_bms.txt
>> > @@ -0,0 +1,93 @@
>> > +Qualcomm Battery Measurement System
>> > +
>> > +The Qualcomm Battery Measurement System is found inside of Qualcomm PM8941
>>
>> Is it Monitoring or Measurment?
>>
>> > +PMICs. It provides OCV and coulomb counter registers that allow the kernel
>> > +to infer a capacity level.
>>
>> s/kernel/OS/
>>
>> OCV?
>>
>> > +
>> > +Required properties:
>> > +- compatible:               Should contain "qcom,pm8941-bms".
>> > +- reg:                      Specifies the SPMI address and length of the
>> > +                       controller's registers.
>> > +- interrupts:               OCV threshold interrupt.
>> > +- io-channels:              Should contain IIO channel specifier for the
>> > +                       ADC channel that reports battery temperature.
>> > +- io-channel-names:         Should contain "temp".
>> > +- qcom,fcc-temp-legend:     An array containing the temperature, in degC,
>> > +                       for each column of the FCC lookup table.
>>
>> What's FCC?
>>
>> > +- qcom,fcc-lut:             An array of FCC values in mah, one entry for each
>> > +                       temperature defined in in qcom,fcc-temp-legend.
>> > +- qcom,ocv-temp-legend:     An array containing the temperature, in degC,
>> > +                       for each column of the OCV lookup table.
>> > +- qcom,ocv-capacity-legend: An array containing the capacity for each
>> > +                       row of the OCV lookup table.
>> > +- qcom,ocv-lut:             An array of OCV values in mV, one entry for each
>> > +                       capacity defined in qcom,ocv-capacity-legend.
>>
>> Need to specify the sizes of these if not 32-bit.
>>
>> All these seem to have units, so add unit suffixes as defined in
>> property-units.txt.
> Should i change code to use microamphours & microvolts or add a new
> suffix?

It is preferred to use the existing ones unless you have some
justification to add new ones.

Rob
