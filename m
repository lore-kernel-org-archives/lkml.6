Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F0A5EC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5460208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eAHbALGX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VnB6OBjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5460208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965806AbeFNOgf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:36:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56264 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965617AbeFNOga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:36:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ABB366090E; Thu, 14 Jun 2018 14:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528986989;
        bh=jJ+VAuK3s8uNaDEsQDQ6nnQc/PZyJ19wOlUZHP2Fxlw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=eAHbALGXzdWTeR50RODrypKTqhN6UKLRXVtkIWcDLCTDlN062LgGkw6LuYoFVXUfQ
         7YTzZzsh0fpcbU3FU07zl7KnVyEbMBqgWbzlqXM0i8ZbZRLjKktqI+UhMPivs4HqDq
         0nYoIvvI24nzg4DSWeF+wl7JieUr12VBMo3m8zzo=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A26C7607A4;
        Thu, 14 Jun 2018 14:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528986988;
        bh=jJ+VAuK3s8uNaDEsQDQ6nnQc/PZyJ19wOlUZHP2Fxlw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=VnB6OBjQkwCmjNSDZSxXcvN+YRv6w4hdaRpwD/eRQdc2vY4XlYXdF3m6lCsW8+lRe
         R6V/T9q798cq0+YY3GlFN1hC/Ii63fapv8aCRJAagnEx6lgVFSC+YS5vQOBNM0OZ9e
         1MWF14hVpyORE1bs3CP3tT7z59/4eDYoXyGEBWBs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A26C7607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>,
        Colin King <colin.king@canonical.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: pcie: make array prop static, shrinks object size
References: <20180611171537.14597-1-colin.king@canonical.com>
        <7f508dccf95cff7fb8e083666b8939c58f65f894.camel@perches.com>
        <20180611204506.GA21542@kroah.com>
Date:   Thu, 14 Jun 2018 17:36:23 +0300
In-Reply-To: <20180611204506.GA21542@kroah.com> (Greg Kroah-Hartman's message
        of "Mon, 11 Jun 2018 22:45:06 +0200")
Message-ID: <878t7h8mfs.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Mon, Jun 11, 2018 at 12:40:55PM -0700, Joe Perches wrote:
>> (adding Greg KH)
>> 
>> Now what is happening is that prop is being reloaded
>> each invocation with the constant addresses of the strings.
>> 
>> It seems the prototype and function for kobject_uevent_env
>> should change as well to avoid this.
>> 
>> Perhaps this should become:
>> ---
>>  drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 2 +-
>>  include/linux/kobject.h                         | 2 +-
>>  lib/kobject_uevent.c                            | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
>> index 7229991ae70d..6668a8aad22e 100644
>> --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
>> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
>> @@ -1946,7 +1946,7 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
>>  	struct iwl_trans_pcie_removal *removal =
>>  		container_of(wk, struct iwl_trans_pcie_removal, work);
>>  	struct pci_dev *pdev = removal->pdev;
>> -	char *prop[] = {"EVENT=INACCESSIBLE", NULL};
>> +	static const char * const prop[] = {"EVENT=INACCESSIBLE", NULL};
>>  
>>  	dev_err(&pdev->dev, "Device gone - attempting removal\n");
>>  	kobject_uevent_env(&pdev->dev.kobj, KOBJ_CHANGE, prop);
>> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
>> index 7f6f93c3df9c..9f5cf553dd1e 100644
>> --- a/include/linux/kobject.h
>> +++ b/include/linux/kobject.h
>> @@ -217,7 +217,7 @@ extern struct kobject *firmware_kobj;
>>  
>>  int kobject_uevent(struct kobject *kobj, enum kobject_action action);
>>  int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
>> -			char *envp[]);
>> +			const char * const envp[]);
>>  int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count);
>>  
>>  __printf(2, 3)
>> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
>> index 63d0816ab23b..9107989a0cc8 100644
>> --- a/lib/kobject_uevent.c
>> +++ b/lib/kobject_uevent.c
>> @@ -452,7 +452,7 @@ static void zap_modalias_env(struct kobj_uevent_env *env)
>>   * corresponding error when it fails.
>>   */
>>  int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
>> -		       char *envp_ext[])
>> +		       const char * const envp_ext[])
>>  {
>>  	struct kobj_uevent_env *env;
>>  	const char *action_string = kobject_actions[action];
>
> No objection from me, care to make it a real patch so that I can apply
> it after 4.18-rc1 is out?

For the wireless part:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
Kalle Valo
