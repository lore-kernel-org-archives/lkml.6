Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D56C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 22:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D082084A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 22:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391147AbeLVWMO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 17:12:14 -0500
Received: from mail-oln040092067059.outbound.protection.outlook.com ([40.92.67.59]:17472
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390220AbeLVWMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 17:12:14 -0500
Received: from AM5EUR02FT060.eop-EUR02.prod.protection.outlook.com
 (10.152.8.55) by AM5EUR02HT052.eop-EUR02.prod.protection.outlook.com
 (10.152.9.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1471.13; Sat, 22 Dec
 2018 22:12:08 +0000
Received: from DB7PR03MB4681.eurprd03.prod.outlook.com (10.152.8.57) by
 AM5EUR02FT060.mail.protection.outlook.com (10.152.9.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.13 via Frontend Transport; Sat, 22 Dec 2018 22:12:08 +0000
Received: from DB7PR03MB4681.eurprd03.prod.outlook.com
 ([fe80::4528:b917:99ee:4ae1]) by DB7PR03MB4681.eurprd03.prod.outlook.com
 ([fe80::4528:b917:99ee:4ae1%3]) with mapi id 15.20.1446.022; Sat, 22 Dec 2018
 22:12:08 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Chen-Yu Tsai <wens@csie.org>, Code Kipper <codekipper@gmail.com>
CC:     Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Mark Brown <broonie@kernel.org>,
        "Maxime Ripard" <maxime.ripard@free-electrons.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] [PATCH v3 1/9] ASoC: sun4i-i2s: Adjust regmap
 settings
Thread-Topic: [alsa-devel] [PATCH v3 1/9] ASoC: sun4i-i2s: Adjust regmap
 settings
Thread-Index: AQHUmkNh+epgLTmWFES3de0wBo24uA==
Date:   Sat, 22 Dec 2018 22:12:08 +0000
Message-ID: <DB7PR03MB46813005FFDFC8609F67F111ACB90@DB7PR03MB4681.eurprd03.prod.outlook.com>
References: <20181221152110.17982-1-codekipper@gmail.com>
 <20181221152110.17982-2-codekipper@gmail.com>
 <CAGb2v66-JmONW9AYqoSmifrEj+nstREdsbkcy9ECwnJ47zxARA@mail.gmail.com>
In-Reply-To: <CAGb2v66-JmONW9AYqoSmifrEj+nstREdsbkcy9ECwnJ47zxARA@mail.gmail.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0198.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::22) To DB7PR03MB4681.eurprd03.prod.outlook.com
 (2603:10a6:10:1f::17)
x-incomingtopheadermarker: OriginalChecksum:B20AFBB833656B7950C622BE4B6FE81E452DC09E684068F40DDCC5C8BFB58A6A;UpperCasedChecksum:95F054D451C2D971EED71C00CAC14553644FBEB30AA08BDAC6E49DEB9A6AEF57;SizeAsReceived:7964;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [oO45OK37Ek8DbjyVIuJoJ1pgZ26Jngcf]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5EUR02HT052;6:Lks8qM1epIl9/ichi7OrHKJpoDzJ9Og40B3JIHPmXWlRS4JDrfO2OlCYDppxOQu9N49mUA4GdxSA0kg9hK/jSuEuAh15qIMTFs4TMLediHOh4vwvVKQvLFq6kyWM44HdipAxT4BwtFyXwsr5UJpVQDZQ6mBEjKXKhwO6AjH1yFSLxH1TL4iwokvXDGrT+9rPvlQ8BSrVRZ5CVdL79M9H9Fl+vS2ww2c/vS0tKP4UvA+66ky2zYHpiRuLvBDU4Uj46LrcWGF2I7kMRKYp4hGJ0P8pwGhVVd2kqeW184S4DbzkLlSPYHUxg1N95nr7TwrtFfV3QWRvEghuHSN796qlLP7gVkYYEmKRTamX6ipCqy7kuYmaksVLrOUM8RIHoeeVJFiu1bSCIyOFloTsQLKXPd+vYvdUDkv1QvpBOFBgg6dutqNT6TckrH/qLKPFnyu+Qh8qC3x8dgelDJ48DY5T+A==;5:EK36V7zRfnHmhd5ykvPo+DHNZxxUEAkNgIvQJ9ayrRfRcNvKIa8UWj2hAyWW6gmPjUERT6mkFqInl2GOHFQNne161MW+b4D/mYt83iIm9NhXWEBlRqy0HiqoNSoMV2qysIuO5e/wnZfdO6wOBeT6YxQGOZd8649pZAF1mWs/HAk=;7:jozZ66m0DYpemgaOywQo7+jlsdTqudwAC9P5BYwhPHcGpmRapFDlD066dMm+PxedOCDdcvwOyr4SjnbOWSVdpvDWF09q6uneEJd9lGIxCAaiqYjIGjnhHad/7DZXrVVljTc2OhhmP25XDxDCeFVyQg==
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:AM5EUR02HT052;
x-ms-traffictypediagnostic: AM5EUR02HT052:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:AM5EUR02HT052;BCL:0;PCL:0;RULEID:;SRVR:AM5EUR02HT052;
x-microsoft-antispam-message-info: IIQwvVXR7Lm+xnV5kCw8n9Kg8Av9D9ReEFqbRkh9N/n1WrRsO9h4mQNRqdU2yC4Q
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <F307A1F0ECBB5B4EB50C38F5BE1EB0D6@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 54485d23-c432-40fe-8436-6091d627118c
X-MS-Exchange-CrossTenant-Network-Message-Id: f88631fb-4d64-4f5e-436c-08d6685a8385
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 54485d23-c432-40fe-8436-6091d627118c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2018 22:12:08.7241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-21 17:44, Chen-Yu Tsai wrote:
> On Fri, Dec 21, 2018 at 11:21 PM <codekipper@gmail.com> wrote:
>> From: Marcus Cooper <codekipper@gmail.com>
>>
>> Bypass the regmap cache when flushing the i2s FIFOs and modify the tables
>> to reflect this.
>>
>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>> ---
>>  sound/soc/sunxi/sun4i-i2s.c | 29 +++++++++--------------------
>>  1 file changed, 9 insertions(+), 20 deletions(-)
>>
>> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
>> index d5ec1a20499d..64d073cb2aee 100644
>> --- a/sound/soc/sunxi/sun4i-i2s.c
>> +++ b/sound/soc/sunxi/sun4i-i2s.c
>> @@ -548,9 +548,11 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>>  static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
>>  {
>>         /* Flush RX FIFO */
>> +       regcache_cache_bypass(i2s->regmap, true);
>>         regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
>>                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX,
>>                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX);
>> +       regcache_cache_bypass(i2s->regmap, false);
> IIRC the flush cache bit is self-clearing. So you likely want to mark
> this register as volatile. If it is marked as volatile, then all access
> to that register bypasses the cache, so the regcache_cache_bypass calls
> are unneeded.

I helped test this together with Marcus and when I tested with this
register marked
as volatile audio started to stutter, still unclear why audio starts to
stutter.

Without this cache bypass the flush TX/RX bits gets cached and flush
happens unexpectedly
resulting in multi channel audio getting mapped to wrong speaker.
Other ASoC codecs and fsl_spdif.c seems to use similar cache bypass for
reset/flush.

>
> However, looking at the code, the write would seem to be ignored if the
> regmap is in the cache_only state. We only set this when the bus clock
> is disabled. Under such a condition, bypassing the cache and forcing a
> write would be unwise, as the system either drops the write, or stalls
> altogether.
>
>>         /* Clear RX counter */
>>         regmap_write(i2s->regmap, SUN4I_I2S_RX_CNT_REG, 0);
>> @@ -569,9 +571,11 @@ static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
>>  static void sun4i_i2s_start_playback(struct sun4i_i2s *i2s)
>>  {
>>         /* Flush TX FIFO */
>> +       regcache_cache_bypass(i2s->regmap, true);
>>         regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
>>                            SUN4I_I2S_FIFO_CTRL_FLUSH_TX,
>>                            SUN4I_I2S_FIFO_CTRL_FLUSH_TX);
>> +       regcache_cache_bypass(i2s->regmap, false);
>>
>>         /* Clear TX counter */
>>         regmap_write(i2s->regmap, SUN4I_I2S_TX_CNT_REG, 0);
>> @@ -703,13 +707,7 @@ static const struct snd_soc_component_driver sun4i_i2s_component = {
>>
>>  static bool sun4i_i2s_rd_reg(struct device *dev, unsigned int reg)
>>  {
>> -       switch (reg) {
>> -       case SUN4I_I2S_FIFO_TX_REG:
>> -               return false;
>> -
>> -       default:
>> -               return true;
>> -       }
>> +       return true;
> I don't understand why this is relevant. Do you need to read back from the TX
> FIFO?

This change was inspired by c66234cfedfc "ASoC: rockchip: i2s: fix
playback after runtime resume" [1]
On resume a cached sample would be written to FIFO_TX_REG unless it is
marked volatile,
the rockchip commit indicated that read is needed for volatile regs.

[1]
https://github.com/torvalds/linux/commit/c66234cfedfc3e6e3b62563a5f2c1562be09a35d

>
> If so, just drop the call-back altogether. If no callback is provided and no
> rd_table is provided either, it defaults to all registers under max_register
> (if max_register < 0) are readable.
>
> However this seems like it deserves to be a separate patch (where you explain
> in the commit log why it's needed).
>
> Regards
> ChenYu
>
>>  }
>>
>>  static bool sun4i_i2s_wr_reg(struct device *dev, unsigned int reg)
>> @@ -728,6 +726,8 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
>>  {
>>         switch (reg) {
>>         case SUN4I_I2S_FIFO_RX_REG:
>> +       case SUN4I_I2S_FIFO_TX_REG:
>> +       case SUN4I_I2S_FIFO_STA_REG:
>>         case SUN4I_I2S_INT_STA_REG:
>>         case SUN4I_I2S_RX_CNT_REG:
>>         case SUN4I_I2S_TX_CNT_REG:
>> @@ -738,23 +738,12 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
>>         }
>>  }
>>
>> -static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
>> -{
>> -       switch (reg) {
>> -       case SUN8I_I2S_FIFO_TX_REG:
>> -               return false;
>> -
>> -       default:
>> -               return true;
>> -       }
>> -}
>> -
>>  static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int reg)
>>  {
>>         if (reg == SUN8I_I2S_INT_STA_REG)
>>                 return true;
>>         if (reg == SUN8I_I2S_FIFO_TX_REG)
>> -               return false;
>> +               return true;
>>
>>         return sun4i_i2s_volatile_reg(dev, reg);
>>  }
>> @@ -809,7 +798,7 @@ static const struct regmap_config sun8i_i2s_regmap_config = {
>>         .reg_defaults   = sun8i_i2s_reg_defaults,
>>         .num_reg_defaults       = ARRAY_SIZE(sun8i_i2s_reg_defaults),
>>         .writeable_reg  = sun4i_i2s_wr_reg,
>> -       .readable_reg   = sun8i_i2s_rd_reg,
>> +       .readable_reg   = sun4i_i2s_rd_reg,
>>         .volatile_reg   = sun8i_i2s_volatile_reg,
>>  };
>>
>> --
>> 2.20.1
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
>
