Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D355C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D0E20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BwyJMe7u";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c5iUosf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D0E20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937272AbeFSDye (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 23:54:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44372 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937237AbeFSDyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 23:54:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E9C6060B13; Tue, 19 Jun 2018 03:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529380471;
        bh=Cl6zZAe2BfHHFdEVnMgiSA879rkfmWwdBs1fu0n+20o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BwyJMe7ufV+cNxIwFvcCrZ3Go03PEbhbLGk9qdCBzAynMGABQ+CABUqm5X+glA4fz
         +BRnEkMYEfv/gepzxGDxnTMNp8M4rcUHaW/ERzE3nUff4UxZHnr2r+gC/3QaMiXNrm
         KE08C/RoY4mi6NnKeeMG0gMP7T1/lp11gpCijx18=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D825360714;
        Tue, 19 Jun 2018 03:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529380470;
        bh=Cl6zZAe2BfHHFdEVnMgiSA879rkfmWwdBs1fu0n+20o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c5iUosf7vNZuLd1ZMmT8os/hPVdkyFi/T/v25mDHlLpy/c9StEkXTFAHOuqD/+7pn
         CB3Nx1RsABT4mbLbS+3SgkX6aPGyT0nsletxuYr4+KjbIH3og7DxdUmkNYz2EaqZrZ
         a9QmDKyRb0pV4sC8FMTHv93opFCBO6lJkMh36HQ0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 Jun 2018 09:24:30 +0530
From:   Govind Singh <govinds@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        david.brown@linaro.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6]  *** Add support for wifi QMI client driver ***
In-Reply-To: <20180619021742.GA17220@rodete-desktop-imager.corp.google.com>
References: <20180605123304.31969-1-govinds@codeaurora.org>
 <20180619021742.GA17220@rodete-desktop-imager.corp.google.com>
Message-ID: <b0922cebf095db4471adcfb18b750cc5@codeaurora.org>
X-Sender: govinds@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-19 07:47, Brian Norris wrote:
> Hi Govind,
> 
> One more side note: this series is called v2, but I see an older v3.
> What's up with that?
> 

Earlier was typo, it was first version.

> On Tue, Jun 05, 2018 at 06:03:04PM +0530, Govind Singh wrote:
>> Add QMI client driver for Q6 integrated WLAN connectivity subsystem.
>> This module is responsible for communicating WLAN control messages to 
>> FW
>> over QMI interface.
>> 
>> QUALCOMM MSM Interface(QMI) provides the control interface between
>> components running b/w remote processors with underlying transport 
>> layer
>> based on integrated chipset(shared memory) or discrete 
>> chipset(PCI/USB/SDIO/UART).
> 
> So this seems to imply QMI would work with transports that are not
> integrated. Except, your code is directly calling SNOC (one of your
> integrated chipset interfaces) code from the QMI driver. Correct? I
> suppose that's OK for now, but it's a little misleading. If you 
> actually
> intend this to support multiple transports, then you might instead want
> a callback interface for this.
> 

Agree, As of now there is no road-map to support qmi on discrete 
chip-set on ath10k tree.
Probably if required in future we can use some generic callback and 
opaque structures to
make it independent to integrated/discrete chip set.

>> QMI client driver implementation is based on qmi frmework 
>> https://lwn.net/Articles/729924/.
>> 
>> Below is the sequence of qmi handshake.
>> 
>>        QMI CLIENT(APPS)                                         QMI 
>> SERVER(FW in Q6)
>> 
>>                          <------wlan service discoverd----
>> 
>>                        -----connect to wlam qmi service----->
>> 
>>                        ------------wlan info request----->
>> 
>>                        <------------wlan info resp------------
>> 
>>                        ------------msa info req-------->
>> 
>>                      <------------msa info resp------------
>> 
>>                      ------------msa ready req-------->
>> 
>>                      <------------msa ready resp------------
>> 
>>                      <------------msa ready indication-------
>> 
>>                      ------------capability req------->
>> 
>>                     <------------capability resp------------
>> 
>>                     ------------qmi bdf req--------->
>> 
>>                      <------------qmi bdf resp------------
>> 
>>                       ------------qmi cal trigger------->
>> 
>>                   <------------ QMI FW ready indication-------
> 
> Let's see if I'm interpreting this right:
> 
>  * The above process is just initiating a handshake with the QMI
>    service and doesn't actually do any loading of firmware on its own;
>    it just hands things off to the SNOC client driver (and ath10k core)
>    once the firmware is magically ready (??)

Yes, it is initiating the handshakes once qmi service is up on the 
target Q6.

>  * The ATH10K_FW_FEATURE_NON_BMI flag you added previously basically
>    provides a way for a driver (and now we see which driver; it's this
>    QMI / SNOC driver) to completely sidestep the typicaly in-kernel
>    firmware load implementation; in fact, the kernel only reads the
>    WLAN firmware just to parse some feature flags, not to actually
>    program it to the device
>  * Some yet-unmentioned proprietary app is involved to handle
>    sideloading the actual firmware from user space
> 

WLAN fw is running in modem Q6 as user PD(protection domain).
Sequence of user PD loading is given below as per current design of 
Modem Q6 fw.

1) Remote proc PIL driver loads the modem fw/ROOT PD.
2) As part of ROOT pd boot-up it queries to a daemon in apps 
processor(pd_mapper)
to determine how many usre pd's are getting supported in the remote 
processor(Q6).
3)

> Is this correct? If not, please correct me. But if it is:
> 
>  * When does the user space app actually load the WLAN firmware? I'm 
> not
>    sure I can place it in the above diagram.
>  * Is there any open source implementation of this? How am I supposed 
> to
>    actually use this driver, if it relies on proprietary components 
> that
>    I can't review and aren't really even mentioned?
> 


> I hope I'm sorely wrong on this. But if I'm not, I don't see why this
> driver should be merged at all. Linux drivers should be self-sufficient
> wherever possible, and I don't see a good reason why this driver can't
> manage actually loading the WLAN firmware on its own, similar to how 
> the
> BMI component of the ath10k driver loads firmware for other ath10k
> transports. But even more importantly: I believe this driver is hiding
> the fact that it relies on undocumented proprietary components to run 
> on
> the CPU [1] just to make use of it at all.
> 
> Brian
> 
> [1] It's an unfortunate fact of life that Wifi (and in this case,
> modem+Wifi) processors will run proprietary firmware, but it's not
> accepted that Linux relies on proprietary user space.
> 
>> Changes in V2:
>> 	Removed qmi client driver and integrated qmi client handshakes in 
>> snoc platform driver.
>> 	Addressed comments v1 version.
>> 	Switched to ath10k bdf download infra(board-2.bin)
>> 	Added MSA fixed region support to support unload use-case.
>> 	Unified logging.
>> 
>> Testing:
>> 	Tested all qmi handshakes, driver load/unload and STA/SAP sanity 
>> testing.
>> 	Tested HW: SDM845(WCN3990)
>> 	Tested FW: WLAN.HL.2.0-01192-QCAHLSWMTPLZ-1
>> 
>> 
>> 
>> Govind Singh (5):
>>   ath10k: Add qmi service helpers for wcn3990 qmi client
>>   dt: bindings: add bindings for msa memory region
>>   ath10k: Add debug mask for QMI layer
>>   firmware: qcom: scm: Add WLAN VMID for Qualcomm SCM interface
>>   ath10k: Add QMI message handshake for wcn3990 client
>> 
>> Rakesh Pillai (1):
>>   ath10k: Add support to create boardname for non-bmi target
>> 
>>  .../bindings/net/wireless/qcom,ath10k.txt     |    4 +
>>  drivers/net/wireless/ath/ath10k/Kconfig       |   13 +-
>>  drivers/net/wireless/ath/ath10k/Makefile      |    4 +-
>>  drivers/net/wireless/ath/ath10k/core.c        |   20 +-
>>  drivers/net/wireless/ath/ath10k/core.h        |    4 +
>>  drivers/net/wireless/ath/ath10k/debug.h       |    1 +
>>  drivers/net/wireless/ath/ath10k/qmi.c         | 1030 ++++++++
>>  drivers/net/wireless/ath/ath10k/qmi.h         |  136 ++
>>  .../net/wireless/ath/ath10k/qmi_wlfw_v01.c    | 2072 
>> +++++++++++++++++
>>  .../net/wireless/ath/ath10k/qmi_wlfw_v01.h    |  677 ++++++
>>  drivers/net/wireless/ath/ath10k/snoc.c        |  209 +-
>>  drivers/net/wireless/ath/ath10k/snoc.h        |    3 +
>>  include/linux/qcom_scm.h                      |    4 +-
>>  13 files changed, 4160 insertions(+), 17 deletions(-)
>>  create mode 100644 drivers/net/wireless/ath/ath10k/qmi.c
>>  create mode 100644 drivers/net/wireless/ath/ath10k/qmi.h
>>  create mode 100644 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.c
>>  create mode 100644 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h
>> 
>> --
>> 2.17.0
>> 
