Return-Path: <jorge.sanjuan@codethink.co.uk>
X-Google-Smtp-Source: AIpwx49UJyUIGfqlXkz5bcdEuUUd76q+W8Jamjygg7CKhNJKlnWU4oUxRdntlX/BGqcnMm3ujqlL
ARC-Seal: i=1; a=rsa-sha256; t=1524761801; cv=none;
        d=google.com; s=arc-20160816;
        b=LtTOSjqnE0eNq6D2RR5BjPtHEaRc0cq2IhmfhjqWO5w25FWp+dEeMjGLVADTs+K1JG
         q2oxUeIJWyLkovJ/pmECL98nT7uIX6FdKR3i94BoAv1S37pKh1/YUNCTY1YKVde/GnOG
         luOcmKLdZZi52o1mByqHD7lhl7KnI8V8oHM8eutZUYepZ4oDp11e+PQWi07BV1kuySuU
         x8ISW8H2YWVjPkxTLUMCCpfhWOIlng8itDlo9xkUgtJEu55Kel4blhHV7+jRPULg42Ms
         fY1oILVFM/1S9wP+zTFu+f7WXZdEQxvyzUxG83EJZJC6DXqZDjpreWw9HGDqsOJDti+O
         v5eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=Akb+bQfaGKWvjrIvDkqDItvyrRcfqLEY4y8alxM94tA=;
        b=z6Ky277BypvVLApUqDNxECR1slWM9Dsdov7Ps6w8rzbKtXotzV1F4dS/VtGHyqIn8L
         GA+bpr8IcsZ70QhcGjwmju134z5HnkERVYaUOl4PgMrRlvDhZqyAwplqd5gn/aFQ1N31
         SY+C4MUiMToMblhGwFKaPYAVZ7EkWCmcn3shbJ4mrzmnHAARoeoqw5JUqrsFniRnITFB
         0R+es7yWr6W/BqT65N3/XLYAK2hSesu+9RKuaaAyhM+4+QcgWBci9mLpD3oT3ZstKbO/
         eVDDV1EYj/L1PGEJSfHJS2uZt37MyZaKqJPQ9GvEyehjBGp6gkRB7VSID9zD+CXONvXH
         U4Rw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jorge.sanjuan@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=jorge.sanjuan@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jorge.sanjuan@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=jorge.sanjuan@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Subject: Re: [alsa-devel] [PATCH v2 1/4] ALSA: usb-audio: UAC3. Add support
 for mixer unit.
To: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
 <20180424172445.31928-1-jorge.sanjuan@codethink.co.uk>
 <20180424172445.31928-2-jorge.sanjuan@codethink.co.uk>
 <CAB=otbQPX4QW8DKNGTS1dCRg2FUp46KCYL+ADnG=VkWPjg3YuQ@mail.gmail.com>
From: Jorge <jorge.sanjuan@codethink.co.uk>
Message-ID: <3dbeff72-d3c8-7a6d-4b46-61ca9d175eda@codethink.co.uk>
Date: Thu, 26 Apr 2018 17:56:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAB=otbQPX4QW8DKNGTS1dCRg2FUp46KCYL+ADnG=VkWPjg3YuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598285487518505397?=
X-GMAIL-MSGID: =?utf-8?q?1598828630944804426?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 25/04/18 23:35, Ruslan Bilovol wrote:
>   On Tue, Apr 24, 2018 at 8:24 PM, Jorge Sanjuan
> <jorge.sanjuan@codethink.co.uk> wrote:
>> This adds support for the MIXER UNIT in UAC3. All the information
>> is obtained from the (HIGH CAPABILITY) Cluster's header. We don't
>> read the rest of the logical cluster to obtain the channel config
>> as that wont make any difference in the current mixer behaviour.
>>
>> The name of the mixer unit is not yet requested as there is not
>> support for the UAC3 Class Specific String requests.
>>
>> Tested in an UAC3 device working as a HEADSET with a basic mixer
>> unit (same as the one in the BADD spec) with no controls.
> 
> The patch looks OK in general, but I have few comments

Thanks for the review! I'll submit v3 of this patch with the suggested 
changes.

Regards,

Jorge

> 
>>
>> Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
>> ---
>>   include/uapi/linux/usb/audio.h | 13 +++++--
>>   sound/usb/mixer.c              | 87 ++++++++++++++++++++++++++++++++++++++++--
>>   2 files changed, 93 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/uapi/linux/usb/audio.h b/include/uapi/linux/usb/audio.h
>> index 3a78e7145689..f9be472cd025 100644
>> --- a/include/uapi/linux/usb/audio.h
>> +++ b/include/uapi/linux/usb/audio.h
>> @@ -285,9 +285,16 @@ static inline __u8 uac_mixer_unit_iChannelNames(struct uac_mixer_unit_descriptor
>>   static inline __u8 *uac_mixer_unit_bmControls(struct uac_mixer_unit_descriptor *desc,
>>                                                int protocol)
> 
> Name of this function is ambiguous, that's because UAC1 mixer unit
> has only bmControls bitmap, whereas UAC2/3 mixer unit has two
> bitmaps (bmMixerControls and bmControls), in latter case this func
> returns pointer to bmMixerControls.
> 
> Maybe in the future we will need to rename it, but at least having
> comment which clarifies that in case of UAC2/3 this function actually
> returns pointer to bmMixerControls here will be helpful for code readers.
> 
>>   {
>> -       return (protocol == UAC_VERSION_1) ?
>> -               &desc->baSourceID[desc->bNrInPins + 4] :
>> -               &desc->baSourceID[desc->bNrInPins + 6];
>> +       switch (protocol) {
>> +       case UAC_VERSION_1:
>> +               return &desc->baSourceID[desc->bNrInPins + 4];
>> +       case UAC_VERSION_2:
>> +               return &desc->baSourceID[desc->bNrInPins + 6];
>> +       case UAC_VERSION_3:
>> +               return &desc->baSourceID[desc->bNrInPins + 2];
>> +       default:
>> +               return NULL;
>> +       }
>>   }
>>
>>   static inline __u8 uac_mixer_unit_iMixer(struct uac_mixer_unit_descriptor *desc)
>> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
>> index 301ad61ed426..bf701b466a4e 100644
>> --- a/sound/usb/mixer.c
>> +++ b/sound/usb/mixer.c
>> @@ -719,6 +719,66 @@ static int get_term_name(struct mixer_build *state, struct usb_audio_term *iterm
>>   }
>>
>>   /*
>> + * Get logical cluster information for UAC3 devices.
>> + */
>> +static int get_cluster_channels_v3(struct mixer_build *state, unsigned int cluster_id)
>> +{
>> +       struct uac3_cluster_header_descriptor c_header;
>> +       int err;
>> +
>> +       err = snd_usb_ctl_msg(state->chip->dev,
>> +                       usb_rcvctrlpipe(state->chip->dev, 0),
>> +                       UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
>> +                       USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
>> +                       cluster_id,
>> +                       snd_usb_ctrl_intf(state->chip),
>> +                       &c_header, sizeof(c_header));
>> +       if (err < 0)
>> +               goto error;
>> +       if (err != sizeof(c_header)) {
>> +               err = -EIO;
>> +               goto error;
>> +       }
>> +
>> +       return c_header.bNrChannels;
>> +
>> +error:
>> +       usb_audio_err(state->chip, "cannot request logical cluster ID: %d (err: %d)\n", cluster_id, err);
>> +       return err;
>> +}
>> +
>> +/*
>> + * Get number of channels for a Mixer Unit.
>> + */
>> +static int uac_mixer_unit_get_channels(struct mixer_build *state,
>> +                                      struct uac_mixer_unit_descriptor *desc)
>> +{
>> +       int mu_channels;
>> +
>> +       if (desc->bLength < 11)
>> +               return -EINVAL;
>> +       if (!desc->bNrInPins)
>> +               return -EINVAL;
>> +
>> +       switch (state->mixer->protocol) {
>> +       case UAC_VERSION_1:
>> +       case UAC_VERSION_2:
>> +       default:
>> +               mu_channels = uac_mixer_unit_bNrChannels(desc);
>> +               break;
>> +       case UAC_VERSION_3:
>> +               mu_channels = get_cluster_channels_v3(state,
>> +                               le16_to_cpu(desc->baSourceID[desc->bNrInPins]));
> 
> It would be good to create and use some helper here, for example implement
> uac3_mixer_unit_wClusterDescrID() similar to uac_mixer_unit_bNrChannels().
> It will put all this conversation to a single place and will improve
> code readability.
> 
>> +               break;
>> +       }
>> +
>> +       if (!mu_channels)
>> +               return -EINVAL;
>> +
>> +       return mu_channels;
>> +}
>> +
>> +/*
>>    * parse the source unit recursively until it reaches to a terminal
>>    * or a branched unit.
>>    */
>> @@ -865,6 +925,18 @@ static int check_input_term(struct mixer_build *state, int id,
>>                                  term->name = le16_to_cpu(d->wClockSourceStr);
>>                                  return 0;
>>                          }
>> +                       case UAC3_MIXER_UNIT: {
>> +                               struct uac_mixer_unit_descriptor *d = p1;
>> +
>> +                               err = uac_mixer_unit_get_channels(state, d);
>> +                               if (err < 0)
>> +                                       return err;
>> +
>> +                               term->channels = err;
>> +                               term->type = d->bDescriptorSubtype << 16; /* virtual type */
>> +
>> +                               return 0;
>> +                       }
>>                          default:
>>                                  return -ENODEV;
>>                          }
>> @@ -1801,7 +1873,7 @@ static void build_mixer_unit_ctl(struct mixer_build *state,
>>                                   struct usb_audio_term *iterm)
>>   {
>>          struct usb_mixer_elem_info *cval;
>> -       unsigned int num_outs = uac_mixer_unit_bNrChannels(desc);
>> +       unsigned int num_outs;
>>          unsigned int i, len;
>>          struct snd_kcontrol *kctl;
>>          const struct usbmix_name_map *map;
>> @@ -1814,6 +1886,10 @@ static void build_mixer_unit_ctl(struct mixer_build *state,
>>          if (!cval)
>>                  return;
>>
>> +       num_outs = uac_mixer_unit_get_channels(state, desc);
>> +       if (num_outs < 0)
>> +               return;
> 
> This will produce an extra USB control request in UAC3 case, which we can
> avoid if add num_outs to input parameters of build_mixer_unit_ctl() function.
> This function is used only once inside of parse_audio_mixer_unit() which already
> has channels number request and all needed checks.
> 
> Thanks,
> Ruslan
> 
>> +
>>          snd_usb_mixer_elem_init_std(&cval->head, state->mixer, unitid);
>>          cval->control = in_ch + 1; /* based on 1 */
>>          cval->val_type = USB_MIXER_S16;
>> @@ -1878,14 +1954,17 @@ static int parse_audio_mixer_unit(struct mixer_build *state, int unitid,
>>          int input_pins, num_ins, num_outs;
>>          int pin, ich, err;
>>
>> -       if (desc->bLength < 11 || !(input_pins = desc->bNrInPins) ||
>> -           !(num_outs = uac_mixer_unit_bNrChannels(desc))) {
>> +       err = uac_mixer_unit_get_channels(state, desc);
>> +       if (err < 0) {
>>                  usb_audio_err(state->chip,
>>                                "invalid MIXER UNIT descriptor %d\n",
>>                                unitid);
>> -               return -EINVAL;
>> +               return err;
>>          }
>>
>> +       num_outs = err;
>> +       input_pins = desc->bNrInPins;
>> +
>>          num_ins = 0;
>>          ich = 0;
>>          for (pin = 0; pin < input_pins; pin++) {
>> --
>> 2.11.0
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
