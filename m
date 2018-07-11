Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E191C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296402083D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296402083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=helios.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732507AbeGKLtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:49:22 -0400
Received: from proxy.helios.de ([193.141.98.37]:53151 "EHLO proxy.helios.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbeGKLtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:49:21 -0400
Received: from hpx.helios.de (hpx.helios.de [172.16.0.106])
        by proxy.helios.de (Postfix) with ESMTP id C4CD01F71F;
        Wed, 11 Jul 2018 13:45:21 +0200 (CEST)
Received: from macht.dyn.helios.de (proxy.helios.de [172.16.0.2])
        by hpx.helios.de (Postfix) with ESMTP id A8D4C1F60C;
        Wed, 11 Jul 2018 13:45:21 +0200 (CEST)
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?Q?Michael_R=c3=b6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        =?UTF-8?Q?Konstantin_B=c3=b6hm?= <konstantin.boehm@ancud.de>,
        Jan Jongboom <jan.jongboom@arm.com>,
        Jon Ortego <Jon.Ortego@imst.de>, contact@snootlab.com,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw,
        lora@radioshuttle.de, Alexander Graf <agraf@suse.de>,
        =?UTF-8?Q?Michal_Kube=c4=8dek?= <mkubecek@suse.cz>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Steve deRosier <derosier@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Hasnain Virk <Hasnain.Virk@arm.com>
References: <20180701110804.32415-1-afaerber@suse.de>
 <487df785-ddf5-ed81-a253-6afb7f2de811@datenfreihafen.org>
 <5aac9ea5-484c-1b3b-8058-50e11e8d7a9a@helios.de>
 <23213cab-dc87-118c-1750-cd30d60ce9f8@suse.de>
From:   Helmut Tschemernjak <helmut@helios.de>
Organization: HELIOS Software GmbH
Message-ID: <5fed8b9a-20a3-4677-0213-ac2814c4aaa9@helios.de>
Date:   Wed, 11 Jul 2018 13:45:22 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <23213cab-dc87-118c-1750-cd30d60ce9f8@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andreas,

here are a few comments in response to your answer.

The SX1276 can do MTU sizes up to 2048 bytes, there is a FIFO and 
corresponding interrupts to handle this, details are in datasheet.

Regarding the LoRaWAN concept, when companies like Semtech and IBM 
designing such a thing, and other companies (Stackforce) implementing 
the code for it. This does not mean automatically that it is good for 
most use cases. Specifically the idea of the concentrator has major 
limits. Check out our article and picture: "Protocols: LoRaWANTM vs 
RadioShuttle" at http://www.radioshuttle.de/en/radioshuttle-2/protocol/

Again my opinion is that that such a specific driver is not needed in 
the kernel.

I am happy to provide further feedback, when you have questions about 
the SX1276Generic driver which I maintain, I am available to discuss 
this. And again the open source driver works on mbed, arduino and can be 
easily adopted to Linux user space and other environments.

Regards
Helmut


On 11/07/18 04:07, Andreas Färber wrote:
> Dear Helmut,
>
> Am 05.07.2018 um 12:43 schrieb Helmut Tschemernjak:
>> I put the kernel support for the SX1276 LoRa chip in question. I don’t
>> think that this kind of device should be in the Linux kernel.
> Thanks for sharing your opinion.
>
>> Here are a few facts to consider:
>> - A LoRa transaction is very slow  (e.g. SF7 needs about 210 ms, for
>> SF12 6280 ms) for 12 bytes user data with acknowledge.
> Where do you see a problem? If you look at my SX1276 patch, you will
> find that it queues a work item for the transmission (asynchronously)
> and has an interrupt handler to get notified of the TX interrupt. It
> surely won't get quicker in userspace - and as you point out, we're not
> speaking about DPDK performance here, so no need for polling.
>
>> - There are many different implementations for the antenna switch,
>> switching between receiving/sending, PA-BOOST, 433, 868/915 MHz. (I know
>> SX1276 Heltec ESP32, SX1276 Murata, RFM95-(1276), SX1276 Heltec
>> STM32-L4) they are all different regarding this.
> Yes, and as demonstrated with this patch series, the kernel is well able
> to handle this variety of interfaces. I would say better than userspace!
>
> As noted, I've tested both 868 MHz and 433 MHz modules. My SX1276 driver
> uses the Device Tree (radio-frequency) to configure the driver when this
> was a property of the module. RN2483 by contrast supports two, so a
> netlink interface was suggested to configure this at runtime.
>
>> - The LoRa chip device ID is only 8-bit which is not sufficient for
>> larger networks, e.g. our RadioShuttle protocol uses compressed 32-bit
>> device IDs.
> What does that have to do with anything? The whole reason that you're
> CC'ed on this patchset is to make sure that you or someone else can
> implement your custom protocol on top of the APIs being proposed. So
> my-protocol-is-better-than-theirs is no argument against this project.
>
> The way I understand LoRa and thus designed the struct sockaddr_lora is
> that there is no ID involved for LoRa at all - it is essentially a
> broadcast. The 8-byte (not 8-bit) EUIs only come into play for LoRaWAN
> AFAIU. Am I missing anything?
>
> LoRaWAN, RadioShuttle, RadioHead and LR Base all have their own ways of
> addressing - the question here is how to model that in Linux, whether as
> one PF_LORA with different protocol options and a growing union
> lora_addr inside sockaddr_lora covering all of them, or a protocol
> family (requiring global number allocation) for each one of them.
>
>> - The chip can do MTU sizes up to 2048 bytes, most protocols use less
>> than 250 bytes.
> How would 2048 bytes work? The FIFO buffer fits a maximum of 256 bytes.
>
> IIRC the recommended MTU is also restricted by the airtime, i.e. SF,
> bandwidth, preamble and other factors...
>
> Some UART based modules allow a maximum of 64 bytes.
>
>> - Applications do on-the-fly channel and spreading factor switching
>> which makes it more difficult for the configuration.
> That's exactly the question of how to implement individual options -
> Device Tree would be fixed for the system's hardware, netlink would be
> user-configurable for the whole network device, whereas socket options
> would be per socket/application, and ioctls might be yet another
> implementation layer.
>
>> - The chip supports Lora modulation as well as  FSK, GFSK, MSK, GMSK,
>> and OOK modulation, for some use cases the other modulations are of
>> interest, e.g. to communicated with other devices.
> Yes, therefore I raised it in the cover letter as open point 5).
>
>> - Power saving modes, like sleep, suspend may be required for battery
>> operation.
> The Linux kernel can deal with that much better than userspace. There's
> pm hooks that one could implement. And SX1276 returns to standby mode
> whenever an operation such as TX is completed. In sleep mode not all
> settings get preserved, so they would need to be saved in the private
> struct and restored on resume.
>
>> - Cad detection is very flexible and can be differently used.
>>
>> - LoRa preamble may be different depending on the protocol used.
>>
>> - The new Lora chip SX1262 / 68 (successor of the SX1276) has different
>> hardware and all different registers, it is driver incompatible with the
>> SX1276. It needs an entire new driver.
> Not unexpected, same as SX1301 being different. As this series shows,
> multiple drivers can easily be implemented as necessary.
>
>> - The device is not multi-process capable (only a single process can
>> communicate with it).
> How is that different from other half-duplex network interfaces? The
> driver needs to take care of appropriate locking of its operations, and
> the socket subsystem should make sure packets get queued accordingly.
>
>> - There are SX1276 LoRa modules with a build-in protocol (LoRaWAN and
>> RAW) via a serial connection only, again complete different API compared
>> the SX1276 chip. Software updates for this devices are difficult.
> Drivers for such modules are already demonstrated in this series.
>
>> - I am even convinced that the LoRaWAN protocol with the concentrator
>> concept is not good, the peer to peer communication and a standard MQTT
>> gateway (what we do) is way more flexible.
> Your opinion in all honors, LoRaWAN is an open specification, whereas
> yours is closed. So whatever benefits yours may have, that way you're
> unlikely to make LoRaWAN go away. People are rolling out LoRaWAN
> gateways, and therefore the question is not which protocol is more
> flexible but rather how all of them can be enabled equally for those
> that want to use them.
>
>> For all this reasons, I feel a user level driver task implementation is
>> way more flexible. I did a lot of work/enhancements on the SX1276 link
>> level driver from Semtech, it is available and maintained on mbed.org
>> and supports mbed-os, Arduino and is prepared for Linux.
>> https://os.mbed.com/users/Helmut64/code/SX1276GenericLib/
>>
>> Protocols e.g. our RadioShuttle LoRa peer to peer protocol or the
>> LoRaWAN protocol can run on top of the SX1276GenericLib. We may should
>> focus on such a driver library getting supported for multiple OS's (Win,
>> Linux, mbed, Ardino, etc.)
>>
>> Again I feel a Linux kernel device driver for the SX1276 chip make
>> little sense for me.
> Well, feel free to use spidev if you prefer. As I pointed out, the Linux
> spi maintainers don't seem to share your view - instead of white-listing
> chipsets for concrete kernel drivers (as you appear to suggest here)
> they rather black-list chipsets to be "allowed" to use spidev if all
> else fails.
>
> Having already done part of the implementation work, for me the question
> is not whether to do a kernel driver but how to do it properly, keeping
> all corner cases in mind, such as non-standard protocols like yours.
> It's great that you're writing an Open Source library for mbed, but its
> name indicates that it offers no abstraction like proposed here.
>
> I'll drop you from v2 then, to not bother you about this Linux kernel
> implementation anymore.
>
> Regards,
> Andreas
>

-- 
best regards / mit freundlichen Gruessen,

Helmut Tschemernjak


HELIOS Software GmbH
Steinriede 3
30827 Garbsen (Hannover)
Phone:    +49-5131-709320
Fax:      +49-5131-709325
Internet    Mail: helmut@helios.de
             Web: http://www.helios.de
             Google+: http://helios.de/helmut

