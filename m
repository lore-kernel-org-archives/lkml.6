Return-Path: <robh@kernel.org>
X-Google-Smtp-Source: AB8JxZomE/QQsUg+UFc4Mfm1wOyeSILePP/eOuPnowxSyBL6yRl132rkYszKEFlOUb0mMQbMHS9n
ARC-Seal: i=1; a=rsa-sha256; t=1524668716; cv=none;
        d=google.com; s=arc-20160816;
        b=IEdBBAa5qImfVYrZxj9LGXO6qPu9XlgAQ2mKo3oDZr6JvVpMfah1loYz2FDN58QLb6
         MuebamXLyamR47sJ9gFXcqQAbV51CZIGtEbQJN/KwTgZreUkvNZZ6hakpabaq9r17EF6
         6XKlLzKjPq33bUtW/I5qSQo/3J4lVop7WlLuhW0UkwNNgrJEridKmc1aZXtY0B0HIdRS
         S1R7N5SpcY/o2F/JD4yVGUJfqxyFfxww5lR8KxKd6EYl9JPo6rTn38hxd0TDkvE9oclc
         rNsGIKW4w7qAl0Mnt2XWn+F9QzZf5lXFc3CGLlKyTAoilxlh2Bl+Vn7LggEuKQJ3Kevv
         KY9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=6alt6dOLguVz96L7Yqdvg6DrTuJxdcWuyPMAz4RvxMU=;
        b=UogRq4DOn8hZ/+jNWrg/Ir7UbQQ3UEGidwkE6NK09WhQkOUwLXJ9gQTaUMsI6j69bV
         RAe9fgc3fOxFoI/mueG5KOiV21pSJayMdQMh5VDJyvBGAowhkhfEG2zZLqy5hbdmvQXF
         2Iy5Sq044e9AtlSHeXbOzUXdR7iXOQP2k55w1WbJ+2/gftm0OIuaga2DH0jhUM3u/Cfc
         f4Pl/Gi4qDFiXVoLKsR9mGFkoBiwv5Xe8QbbKYN0me20C8GuC5XmSj3G0W8h7CnDKuro
         j0lpVvl2xPlJD0iUNtwwra7X3mmuC3fyJQY1YRENIobQcUNipvykXnsmIhKSOTC+PkSv
         J91w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C685D21837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
MIME-Version: 1.0
In-Reply-To: <655a593b-021c-3bf2-35c2-eb77cb0a4b95@linaro.org>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-22-srinivas.kandagatla@linaro.org> <20180424162517.msxscjfg36xc22mo@rob-hp-laptop>
 <655a593b-021c-3bf2-35c2-eb77cb0a4b95@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 25 Apr 2018 10:04:54 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJXpei5vFUKwrQGaV4q3Twkg=SKF=Cx_my7KaLmOc42NQ@mail.gmail.com>
Message-ID: <CAL_JsqJXpei5vFUKwrQGaV4q3Twkg=SKF=Cx_my7KaLmOc42NQ@mail.gmail.com>
Subject: Re: [PATCH v5 21/23] ASoC: qdsp6: dt-bindings: Add apq8096 machine bindings
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>, Mark Brown <broonie@kernel.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Brown <david.brown@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>,
	Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598098804369863616?=
X-GMAIL-MSGID: =?utf-8?q?1598731024066607125?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 11:49 AM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> Thanks for the review.
>
>
> On 24/04/18 17:25, Rob Herring wrote:
>>
>> On Wed, Apr 18, 2018 at 04:31:55PM +0100, srinivas.kandagatla@linaro.org
>> wrote:
>>>
>>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>
>>> Add devicetree bindings documentation file for Qualcomm apq8096 sound
>>> card.
>>>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> ---
>>>   .../devicetree/bindings/sound/qcom,apq8096.txt     | 76
>>> ++++++++++++++++++++++
>>>   1 file changed, 76 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/sound/qcom,apq8096.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
>>> b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
>>> new file mode 100644
>>> index 000000000000..37e23d926b95
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
>>> @@ -0,0 +1,76 @@
>>> +* Qualcomm Technologies APQ8096 ASoC sound card driver
>>> +
>>> +This binding describes the APQ8096 sound card, which uses qdsp for
>>> audio.
>>> +
>>> +- compatible:
>>> +       Usage: required
>>> +       Value type: <stringlist>
>>> +       Definition: must be "qcom,apq8096-sndcard"
>>> +
>>> +- qcom,audio-routing:
>>> +       Usage: Optional
>>> +       Value type: <stringlist>
>>> +       Definition:  A list of the connections between audio components.
>>> +                 Each entry is a pair of strings, the first being the
>>> +                 connection's sink, the second being the connection's
>>> +                 source. Valid names could be power supplies, MicBias
>>> +                 of codec and the jacks on the board:
>>
>>
>> Please list out valid values here.
>
>
> I can list the values for the HDMI playback use-case, but the list would
> grow as we start adding wcd9335 codec support.

If you don't have the values, then how does one validate a DT is correct?

Honestly, a single property like this seems insufficient to describe
audio routing.

>>> +
>>> += dailinks
>>> +Each subnode of sndcard represents either a dailink, and subnodes of
>>> each
>>> +dailinks would be cpu/codec/platform dais.
>>> +
>>> +- link-name:
>>
>>
>> Not a standard property, but I guess that sneaked in with the 8016
>> binding...
>
> Yes, I followed 8016 bindings.
>
> Am happy to prefix this with qcom if that makes more sense.

I'd just leave it to be consistent.
