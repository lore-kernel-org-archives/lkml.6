Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeBDOcA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 09:32:00 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45769 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbeBDObw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 09:31:52 -0500
X-Google-Smtp-Source: AH8x2258iRKdRM3Y0BzNA3zRVj1YXvdV9l4oLw6p7o186iZnwdqfY4ncI07XnhQ0duYWP5qZKfOW1TQYIs3kyBt5y7g=
MIME-Version: 1.0
In-Reply-To: <20180202231102.GA2705@sirena.org.uk>
References: <1517588406-3295-1-git-send-email-daniel.baluta@nxp.com>
 <1517588406-3295-2-git-send-email-daniel.baluta@nxp.com> <CAHp75VfyVfGdCfjV_iaXFcRcanbgwFSgJRfu8eojdbMONMUOaQ@mail.gmail.com>
 <20180202231102.GA2705@sirena.org.uk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 4 Feb 2018 16:31:50 +0200
Message-ID: <CAHp75Vdadii=judzHp_Wt-Yn7Ozyn2ybAKCtWAj=KtyHRsUucw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: codecs: Add support for AK5558 ADC driver
To: Mark Brown <broonie@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wakasugi.jb@om.asahi-kasei.co.jp, "S.j. Wang" <shengjiu.wang@nxp.com>,
        Mihai Serban <mihai.serban@gmail.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Mihai Serban <mihai.serban@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 3, 2018 at 1:11 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Feb 02, 2018 at 09:33:18PM +0200, Andy Shevchenko wrote:
>> On Fri, Feb 2, 2018 at 6:20 PM, Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
>> > +static int ak5558_set_dai_mute(struct snd_soc_dai *dai, int mute)
>> > +{
>> > +       struct snd_soc_codec *codec = dai->codec;
>> > +       struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
>>
>> > +       int ndt = 0;
>>
>> It might be even
>>
>>       int ndt = max(ak5558->fs ? 583000 / ak5558->fs : 5, 5);
>
> Please don't encourage people to use the ternery operator like that, it
> does nothing for legibility not to write out the conditionals.

Noted.

>> > +static const struct i2c_device_id ak5558_i2c_id[] = {
>> > +       { "ak5558", 0 },
>> > +       { }
>> > +};
>> > +MODULE_DEVICE_TABLE(i2c, ak5558_i2c_id);
>
>> I dunno if it's really helpful to have. Though it's up to Mark and you.
>
> I don't care either way.

Since Mark is okay with either, I would rather switch to ->probe_new()
and remove above table.

-- 
With Best Regards,
Andy Shevchenko
