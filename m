Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522251822; cv=none;
        d=google.com; s=arc-20160816;
        b=OpZF7axRgNKaUnkqOE9mZG511tsEPledKxGJu0v1q4OyUm8I7jD/pv2Pzo+Yto97F8
         wlwf4jaVP3pSCBswIkEGp7w7Th34MhQh+OUdP0DFF6VuWLZMKd9HSao9YkrJWO9KV543
         w+3X5cVIGNKTUBIZrGBofn5sVIFZdQ8VbYBlA4KCFTBhVGIaru+hSA3XgdQfYo8wgRnB
         9OEm4a1g/tU3++2ti2HvYOYFFvXgedfmCC2rWUIBiRCeKvwIaeN9+SLEnmK72VS6HcUh
         H4VFKCkIVplRyMIrVbsGPoTysplQe7HJhjcNhSRISX4te2mTIUyHnqie1FlDbovD5wDP
         JZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=PUN0tswLv6+u/DnaFNoaVu6lyrIrZff0lP11C3UeTgw=;
        b=rV1LRlzURaU9rSKvnbs6uocfWr0eVTtao2zhPFgEhN+qHuQWF4hIxsSIuMtg54hzZ6
         EhWeMFstO6/KUeKiMWU9N9n6IEorRyWzCSu5yuHCiJD0aSj5Sn/JEESWvfeVRjEtbNCM
         TyPd0fAb/nCK8F/nniMofnayZmOB1oFsSvvGBYB8lWwIIMNEpUH1AoqZP9S2BvAFjV/u
         O91qQJTPMjW52iO+egB4r55txCYo02Kah7X1UsNiAtp1C+tViGN/VC13VL1LIwU9Lx0o
         0u3QnoJ1hHpWxbs5lrlkyaLMaBN61kU8eq4XJF2WeeUDSr7LEcRqmcgRpdiWDDluHZPi
         4WuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TCl/JsQG;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TCl/JsQG;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AIpwx48xdmHxPnn5AmN747dhopHCn2Ei2F3seWunBc9wuIOloiMo64wH2IlYgZBS1iyQCUoVMLcEc1ri2EMtYaS8sqM=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <HE1PR04MB32126A07A4B4CC7225E661E4E0A30@HE1PR04MB3212.eurprd04.prod.outlook.com>
References: <cover.1521818402.git.ioana.ciornei@nxp.com> <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
 <CAK8P3a089ZiPdp1CcVct8Kac+ejkNP8TrVpWYSr_nMGo4goO1Q@mail.gmail.com> <HE1PR04MB32126A07A4B4CC7225E661E4E0A30@HE1PR04MB3212.eurprd04.prod.outlook.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 28 Mar 2018 17:43:40 +0200
X-Google-Sender-Auth: szD_FQjDGRbMhmlAE_J21M2Pb78
Message-ID: <CAK8P3a1aQCm_r95Ka4x+j8SJLCLFvLuX3A4twK1WJcJs66YwKg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: gregkh <gregkh@linuxfoundation.org>, Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
	Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>, Razvan Stefanescu <razvan.stefanescu@nxp.com>,
	Roy Pledge <roy.pledge@nxp.com>, Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1596196727051645050?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 4:27 PM, Ioana Ciornei <ioana.ciornei@nxp.com> wrote:
> Hi,
>
>>
>> Hi Ioana,
>>
>> So this driver is a direct passthrough to your hardware for passing fixed-
>> length command/response pairs. Have you considered using a higher-level
>> interface instead?
>>
>> Can you list some of the commands that are passed here as clarification, and
>> explain what the tradeoffs are that have led to adopting a low-level interface
>> instead of a high-level interface?
>>
>> The main downside of the direct passthrough obviously is that you tie your
>> user space to a particular hardware implementation, while a high-level
>> abstraction could in principle work across a wider range of hardware revisions
>> or even across multiple vendors implementing the same concept by different
>> means.
>
> If by "higher-level" you mean an implementation where commands are created by the kernel at userspace's request, then I believe this approach is not really viable because of the sheer number of possible commands that would bloat the driver.
>
> For example, a DPNI (Data Path Network Interface) can be created using a command that has the following structure:
>
> struct dpni_cmd_create {
>         uint32_t options;
>         uint8_t num_queues;
>         uint8_t num_tcs;
>         uint8_t mac_filter_entries;
>         uint8_t pad1;
>         uint8_t vlan_filter_entries;
>         uint8_t pad2;
>         uint8_t qos_entries;
>         uint8_t pad3;
>         uint16_t fs_entries;
> };
>
> In the above structure, each field has a meaning that the end-user might want to be able to change according to their particular use-case (not much is left at its default value).
> The same level of complexity is encountered for all the commands that interact with Data Path objects such as DPBP(buffer pools), DPRC(Resource Container) etc.
> You can find more examples of commands in restool's repo: https://github.com/qoriq-open-source/restool/tree/integration/mc_v10
>
> In my opinion, an in-kernel implementation that is equivalent in terms of flexibility will turn
> into a giant ioctl parser, all while also exposing an userspace API that is not as simple/easy to use.

(adding the netdev list)

The command you list there seems to be networking related, so instead of
an ioctl based interface, a high-lever interface would likely use netlink
for consistency with other drivers. Are all commands for networking
or are there some that are talking to the device to do something unrelated?

Obviously creating a high-level interface would be a lot of work in the kernel,
and it only pays off if there are multiple independent users, we wouldn't do
that for just one driver.

I'm still not convinced either way (high-level or low-level
interface), but I think
this needs to be discussed with the networking maintainers. Given the examples
on the github page you linked to, the high-level user space commands
based on these ioctls

   ls-addni   # adds a network interface
   ls-addmux  # adds a dpdmux
   ls-addsw   # adds an l2switch
   ls-listmac # lists MACs and their connections
   ls-listni  # lists network interfaces and their connections

and I see that you also support the switchdev interface in
drivers/staging/fsl-dpaa2, which I think does some of the same
things, presumably by implementing the switchdev API using
fsl_mc_command low-level interfaces in the kernel.

Is that a correct interpretation? If yes, could we extend switchdev
or other networking interfaces to fill in whatever those don't handle
yet?

>> > @@ -14,10 +14,18 @@
>> >   * struct fsl_mc_command - Management Complex (MC) command
>> structure
>> >   * @header: MC command header
>> >   * @params: MC command parameters
>> > + *
>> > + * Used by RESTOOL_SEND_MC_COMMAND
>> >   */
>> >  struct fsl_mc_command {
>> >         __u64 header;
>> >         __u64 params[MC_CMD_NUM_OF_PARAMS];  };
>> >
>> > +#define RESTOOL_IOCTL_TYPE     'R'
>> > +#define RESTOOL_IOCTL_SEQ      0xE0
>>
>> I tried to follow the code path into the hardware and am a bit confused about
>> the semantics of the 'header' field and the data. Both are accessed passed to
>> the hardware using
>>
>>        writeq(le64_to_cpu(cmd->header))
>>
>> which would indicate a fixed byte layout on the user structure and that it
>> should really be a '__le64' instead of '__u64', or possibly should be
>> represented as '__u8 header[8]' to clarify that the byte ordering is supposed
>> to match the order of the byte addresses of the register.
>>
>
> Indeed, the struct fsl_mc_command should use '__le64' instead of '__u64', so that the UAPI header file clearly states what endianness should the userspace prepare.
> The writeq appeared as a consequence of a previous mail thread https://lkml.org/lkml/2017/7/17/415, because the endianness of the command is handled by the user and the bus should leave the binary blob intact.

Ok. However, with the dpni_cmd_create structure you list above, it
seems that it doesn't actually contain a set of __le64 but rather
an array of bytes, so it might be best to

>> However, the in-kernel usage of that field suggests that we treat it as a 64-bit
>> cpu-endian number, for which the hardware needs to know the endianess of
>> the currently running kernel and user space.
>>
>
> I might have not understood what you are trying to say, but the in-kernel code treats the fsl_mc_command as little endian by using cpu_to_leXX and leXX_to_cpu in order to setup the command structure.

One function that seems to have a problem is this one:

static enum mc_cmd_status mc_cmd_hdr_read_status(struct fsl_mc_command *cmd)
{
        struct mc_cmd_header *hdr = (struct mc_cmd_header *)&cmd->header;

        return (enum mc_cmd_status)hdr->status;
}

If cmd->header is little-endian here, then the result is not
an 'enum mc_cmd_status'. I think it would be good to change the
types for fsl_mc_command to __le64 first and run everything through
'sparse' with 'make C=1' to find any remaining endianess problems.

        Arnd
