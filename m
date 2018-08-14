Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF43C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818C82170E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgMBMrKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818C82170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbeHOCrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 22:47:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728119AbeHOCrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 22:47:43 -0400
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com [209.85.161.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84A882170E;
        Tue, 14 Aug 2018 23:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534291087;
        bh=01XDqgzF+7HqaD1pkOZsmZ1HyFXUKtZ/fSsSFb+7MQU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=DgMBMrKeVFzczuPNlEMywcc4zT5spkYNKQIJC/YGqBj0uI2ybg+DctO/rqC+FhVIQ
         jLrdhSNVGOoQjulPsYviMppcc88ohQPD+GsQVDmEBPkczqDXK2n1w3bKY3ahVPoBI7
         mgObw6q1hsNIad3YWFNqokjXD8UljMcVOQOAPjsE=
Received: by mail-yw1-f45.google.com with SMTP id 139-v6so17585019ywg.12;
        Tue, 14 Aug 2018 16:58:07 -0700 (PDT)
X-Gm-Message-State: AOUpUlG5HdMbb2w6muyEsi3IdPw1H2qPg0Hi76d4vuPj/cnNM6XltydD
        2v+WFmy5GYFIeTX/2YyGVEMt1Tz3jz0gHPrBrKo=
X-Google-Smtp-Source: AA+uWPxYyJ9A9yuFvc5wtfX7omGxKngJROLQRwi3vQdUrf+FPOpG+7/Bx2a+0KWuureuv3awPXfuEapOSoAetzMpmKg=
X-Received: by 2002:a25:448b:: with SMTP id r133-v6mr13496670yba.122.1534291086759;
 Tue, 14 Aug 2018 16:58:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:81cc:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 16:57:26
 -0700 (PDT)
In-Reply-To: <3092191.aOBZP6MEga@pcbe13614>
References: <20180725181514.3501-1-atull@kernel.org> <3092191.aOBZP6MEga@pcbe13614>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 14 Aug 2018 18:57:26 -0500
X-Gmail-Original-Message-ID: <CANk1AXTfCsJi1bnGw41V1seGc0c5vW1ZCLdor6x_eso6Uy71Vw@mail.gmail.com>
Message-ID: <CANk1AXTfCsJi1bnGw41V1seGc0c5vW1ZCLdor6x_eso6Uy71Vw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fpga: Document when fpga_blah_free functions should
 be used
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Moritz Fischer <mdf@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 2:26 AM, Federico Vaga <federico.vaga@cern.ch> wrote:
> Hi Alan,
>
> have you considered the possibility of having something like devm_fpga_[mgr|
> bridge|region]_[create|free]() ? Like this, it will be obvious that 'struct
> fpga_mgr' will be released automatically without reading any comment (but the
> comment is still good), and you use devm_*_free() only to handle error
> conditions.

Hi Federico,

Sorry for the late reply.  I was waiting until I had this all
implemented.  As you've seen, I've posted the devm_fpga_mgr_create
implementation [1].  I found I didn't need devm_*_free() for the error
conditions, the managed device code handled cleanup nicely without it.

Just to be clear, I'm dropping this patch in favor of devm support instead.

Thanks again for your suggestions.

Alan

[1] https://lkml.org/lkml/2018/8/14/954

>
> On Wednesday, July 25, 2018 8:15:13 PM CEST Alan Tull wrote:
>> Clarify when fpga_(mgr|bridge|region)_free functions should be used.
>> The class's dev_release will handle cleanup when the device is released
>> so once the mgr/brige/region has been successfully registered, it
>> would be a bug to call fpga_(mgr|bridge|region)_free.
>>
>> Signed-off-by: Alan Tull <atull@kernel.org>
>> Suggested-by: Florian Fainelli <f.fainelli@gmail.com>
>> Suggested-by: Federico Vaga <federico.vaga@cern.ch>
>> ---
>>  drivers/fpga/fpga-bridge.c | 10 +++++++++-
>>  drivers/fpga/fpga-mgr.c    | 10 +++++++++-
>>  drivers/fpga/fpga-region.c | 10 +++++++++-
>>  3 files changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
>> index 24b8f98..528d2149 100644
>> --- a/drivers/fpga/fpga-bridge.c
>> +++ b/drivers/fpga/fpga-bridge.c
>> @@ -379,7 +379,11 @@ EXPORT_SYMBOL_GPL(fpga_bridge_create);
>>
>>  /**
>>   * fpga_bridge_free - free a fpga bridge and its id
>> - * @bridge:  FPGA bridge struct created by fpga_bridge_create
>> + * @bridge:  FPGA bridge struct created by fpga_bridge_create()
>> + *
>> + * Free a FPGA bridge.  This function should only be called for
>> + * freeing a bridge that has not been registered yet (such as in error
>> + * paths in a probe function).
>>   */
>>  void fpga_bridge_free(struct fpga_bridge *bridge)
>>  {
>> @@ -414,6 +418,10 @@ EXPORT_SYMBOL_GPL(fpga_bridge_register);
>>  /**
>>   * fpga_bridge_unregister - unregister and free a fpga bridge
>>   * @bridge:  FPGA bridge struct created by fpga_bridge_create
>> + *
>> + * Unregister the bridge device.  The class's dev_release will handle
>> + * freeing the bridge struct when the device is released so don't
>> + * call fpga_bridge_free() after calling fpga_bridge_unregister().
>>   */
>>  void fpga_bridge_unregister(struct fpga_bridge *bridge)
>>  {
>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
>> index a41b07e..9632cbd 100644
>> --- a/drivers/fpga/fpga-mgr.c
>> +++ b/drivers/fpga/fpga-mgr.c
>> @@ -619,7 +619,11 @@ EXPORT_SYMBOL_GPL(fpga_mgr_create);
>>
>>  /**
>>   * fpga_mgr_free - deallocate a FPGA manager
>> - * @mgr:     fpga manager struct created by fpga_mgr_create
>> + * @mgr:     fpga manager struct created by fpga_mgr_create()
>> + *
>> + * Free a FPGA manager struct.  This function should only be called
>> + * for freeing a manager that has not been registered yet (such as in
>> + * error paths in a probe function).
>>   */
>>  void fpga_mgr_free(struct fpga_manager *mgr)
>>  {
>> @@ -663,6 +667,10 @@ EXPORT_SYMBOL_GPL(fpga_mgr_register);
>>  /**
>>   * fpga_mgr_unregister - unregister and free a FPGA manager
>>   * @mgr:     fpga manager struct
>> + *
>> + * Unregister the manager device.  The class's dev_release will handle
>> + * freeing the manager struct when the device is released so don't
>> + * call fpga_mgr_free() after calling fpga_mgr_unregister().
>>   */
>>  void fpga_mgr_unregister(struct fpga_manager *mgr)
>>  {
>> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
>> index 0d65220..7335fa9 100644
>> --- a/drivers/fpga/fpga-region.c
>> +++ b/drivers/fpga/fpga-region.c
>> @@ -231,7 +231,11 @@ EXPORT_SYMBOL_GPL(fpga_region_create);
>>
>>  /**
>>   * fpga_region_free - free a struct fpga_region
>> - * @region: FPGA region created by fpga_region_create
>> + * @region:  FPGA region created by fpga_region_create()
>> + *
>> + * Free a FPGA region struct.  This function should only be called for
>> + * freeing a region that has not been registered yet (such as in error
>> + * paths in a probe function).
>>   */
>>  void fpga_region_free(struct fpga_region *region)
>>  {
>> @@ -255,6 +259,10 @@ EXPORT_SYMBOL_GPL(fpga_region_register);
>>  /**
>>   * fpga_region_unregister - unregister and free a FPGA region
>>   * @region: FPGA region
>> + *
>> + * Unregister the region device.  The class's dev_release will handle
>> + * freeing the region so don't call fpga_region_free() after calling
>> + * fpga_region_unregister().
>>   */
>>  void fpga_region_unregister(struct fpga_region *region)
>>  {
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
