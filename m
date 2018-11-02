Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96565C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C572081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="LAE/66Uk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W+B+Jr6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C572081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbeKBS02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 14:26:28 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40585 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbeKBS01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 14:26:27 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id AE36621FC5;
        Fri,  2 Nov 2018 05:19:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 02 Nov 2018 05:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm2; bh=r
        RLKi9VKdksWXZyiAgiFjPvcH+UCWgXogOrce+J8M3c=; b=LAE/66Ukxlzi/Lw7E
        3lia04CyL+T8uJKJiUXyifEoX3jXsLYjMMX2lzVgupgGlYEYD07FH1wDeKLmtJrW
        1tSvjL+S3feqpYjlB4WlQWs9djDS1Nmu1ivW3ZOcuXoL4Y7IxPN1R79S9BuFngGG
        kKnTA2Abr26grSjdBj3QfkhIUa0L+EL5YRZxBOFjWyEl3efJP+P23IvSwdTYAQ0/
        i7jkyAMikhLWo39qHbYW6EbXUi3o/Gbi4APVo2Y0y6rXoEZq0nBUoQA76JNLj9Fa
        qf1tFXYrN0aZaSvBAINYPxs0jxDr3ueRhx8Ndt54+0ibtNYjk8MxZByHaMGSz5qb
        e/8Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=rRLKi9VKdksWXZyiAgiFjPvcH+UCWgXogOrce+J8M
        3c=; b=W+B+Jr6fwTKJRWDUHIGVNU368Vej/JAvuvtXubZSEh8MjihbQQAwK3Tsp
        +vQ5PnvOZuabmguEI80ylcQ5hEFjNv7Jxcvv+COji1CdueY11v5w9ASlCFpEbZeR
        afGRXVVNwCOi2WoyG0Ucool9rPVWbZ4neMZw4tSopuTf6ldAtivUMWEwCF/gg9SZ
        T7ARoqTCBTPJfmZ2KlzimJm2XdWghYYA8Y7my14crlD3xhds4lFr/NtKNYl//H5J
        4MQscpEo6A4FmPtHHGwpWlgMP3ssNvHLOG7frkhu1cvWBHsNZvwhfFyfMjEr5RH3
        r7EoR2rTDakheDfBj5B7XJqJzOPzA==
X-ME-Sender: <xms:vBbcWzGnMjEC-5htjWCBIwLdBcehhCvvlQt9vjUsZ2ij7l0HnL2MBQ>
X-ME-Proxy: <xmx:vBbcWyb_UF5F18-M7IiRyrq--el2gc9TTtiEJ8187rvZucwuSD9Nxw>
    <xmx:vBbcW1m9CU0My9jSoGNnMmqPm33hblqzTtM3RR40qQeuyHPH5pOm6g>
    <xmx:vBbcW-zdKXHziH9PntL1gGr2YocXv-o2rM08QDifHSqgrKo1xQM0Zg>
    <xmx:vBbcWzMDjPOGKg43TgAL3pQPdTbEor9hmg1KbG04kYjpA3lkpt1p0Q>
    <xmx:vBbcWyQaGUi6Qy2J79ls_MKNZ1dvTMwgqdTmaxPF8dLbYY43i0LEvA>
    <xmx:vBbcW-MkU2do0uwLYdNHD9agFkfmJ2U_trp7dTuTepqVA6y6f6GzCQ>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id A7CEFE454E;
        Fri,  2 Nov 2018 05:19:55 -0400 (EDT)
Date:   Fri, 2 Nov 2018 10:19:54 +0100
From:   Greg KH <greg@kroah.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH AUTOSEL 4.4 05/25] cfg80211: Address some corner cases in
 scan result channel updating
Message-ID: <20181102091954.GA23989@kroah.com>
References: <20181016041606.135876-1-sashal@kernel.org>
 <20181016041606.135876-5-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181016041606.135876-5-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sasha,

The patch below causes a build warning:
net/wireless/scan.c: In function ‘cfg80211_get_bss_channel’:
net/wireless/scan.c:1015:21: warning: comparison between ‘enum ieee80211_band’ and ‘enum nl80211_band’ [-Wenum-compare]
   if (channel->band == NL80211_BAND_2GHZ) {
                     ^~

So I'm going to drop it from the tree now.  Feel free to resubmit it if
you want to fix it up :)

thanks,

greg k-h


On Tue, Oct 16, 2018 at 12:15:46AM -0400, Sasha Levin wrote:
> From: Jouni Malinen <jouni@codeaurora.org>
> 
> [ Upstream commit 119f94a6fefcc76d47075b83d2b73d04c895df78 ]
> 
> cfg80211_get_bss_channel() is used to update the RX channel based on the
> available frame payload information (channel number from DSSS Parameter
> Set element or HT Operation element). This is needed on 2.4 GHz channels
> where frames may be received on neighboring channels due to overlapping
> frequency range.
> 
> This might of some use on the 5 GHz band in some corner cases, but
> things are more complex there since there is no n:1 or 1:n mapping
> between channel numbers and frequencies due to multiple different
> starting frequencies in different operating classes. This could result
> in ieee80211_channel_to_frequency() returning incorrect frequency and
> ieee80211_get_channel() returning incorrect channel information (or
> indication of no match). In the previous implementation, this could
> result in some scan results being dropped completely, e.g., for the 4.9
> GHz channels. That prevented connection to such BSSs.
> 
> Fix this by using the driver-provided channel pointer if
> ieee80211_get_channel() does not find matching channel data for the
> channel number in the frame payload and if the scan is done with 5 MHz
> or 10 MHz channel bandwidth. While doing this, also add comments
> describing what the function is trying to achieve to make it easier to
> understand what happens here and why.
> 
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  net/wireless/scan.c | 58 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 49 insertions(+), 9 deletions(-)
> 
> diff --git a/net/wireless/scan.c b/net/wireless/scan.c
> index 8dde12a11725..00219f386283 100644
> --- a/net/wireless/scan.c
> +++ b/net/wireless/scan.c
> @@ -974,13 +974,23 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
>  	return NULL;
>  }
>  
> +/*
> + * Update RX channel information based on the available frame payload
> + * information. This is mainly for the 2.4 GHz band where frames can be received
> + * from neighboring channels and the Beacon frames use the DSSS Parameter Set
> + * element to indicate the current (transmitting) channel, but this might also
> + * be needed on other bands if RX frequency does not match with the actual
> + * operating channel of a BSS.
> + */
>  static struct ieee80211_channel *
>  cfg80211_get_bss_channel(struct wiphy *wiphy, const u8 *ie, size_t ielen,
> -			 struct ieee80211_channel *channel)
> +			 struct ieee80211_channel *channel,
> +			 enum nl80211_bss_scan_width scan_width)
>  {
>  	const u8 *tmp;
>  	u32 freq;
>  	int channel_number = -1;
> +	struct ieee80211_channel *alt_channel;
>  
>  	tmp = cfg80211_find_ie(WLAN_EID_DS_PARAMS, ie, ielen);
>  	if (tmp && tmp[1] == 1) {
> @@ -994,16 +1004,45 @@ cfg80211_get_bss_channel(struct wiphy *wiphy, const u8 *ie, size_t ielen,
>  		}
>  	}
>  
> -	if (channel_number < 0)
> +	if (channel_number < 0) {
> +		/* No channel information in frame payload */
>  		return channel;
> +	}
>  
>  	freq = ieee80211_channel_to_frequency(channel_number, channel->band);
> -	channel = ieee80211_get_channel(wiphy, freq);
> -	if (!channel)
> -		return NULL;
> -	if (channel->flags & IEEE80211_CHAN_DISABLED)
> +	alt_channel = ieee80211_get_channel(wiphy, freq);
> +	if (!alt_channel) {
> +		if (channel->band == NL80211_BAND_2GHZ) {
> +			/*
> +			 * Better not allow unexpected channels when that could
> +			 * be going beyond the 1-11 range (e.g., discovering
> +			 * BSS on channel 12 when radio is configured for
> +			 * channel 11.
> +			 */
> +			return NULL;
> +		}
> +
> +		/* No match for the payload channel number - ignore it */
> +		return channel;
> +	}
> +
> +	if (scan_width == NL80211_BSS_CHAN_WIDTH_10 ||
> +	    scan_width == NL80211_BSS_CHAN_WIDTH_5) {
> +		/*
> +		 * Ignore channel number in 5 and 10 MHz channels where there
> +		 * may not be an n:1 or 1:n mapping between frequencies and
> +		 * channel numbers.
> +		 */
> +		return channel;
> +	}
> +
> +	/*
> +	 * Use the channel determined through the payload channel number
> +	 * instead of the RX channel reported by the driver.
> +	 */
> +	if (alt_channel->flags & IEEE80211_CHAN_DISABLED)
>  		return NULL;
> -	return channel;
> +	return alt_channel;
>  }
>  
>  /* Returned bss is reference counted and must be cleaned up appropriately. */
> @@ -1028,7 +1067,8 @@ cfg80211_inform_bss_data(struct wiphy *wiphy,
>  		    (data->signal < 0 || data->signal > 100)))
>  		return NULL;
>  
> -	channel = cfg80211_get_bss_channel(wiphy, ie, ielen, data->chan);
> +	channel = cfg80211_get_bss_channel(wiphy, ie, ielen, data->chan,
> +					   data->scan_width);
>  	if (!channel)
>  		return NULL;
>  
> @@ -1126,7 +1166,7 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
>  		return NULL;
>  
>  	channel = cfg80211_get_bss_channel(wiphy, mgmt->u.beacon.variable,
> -					   ielen, data->chan);
> +					   ielen, data->chan, data->scan_width);
>  	if (!channel)
>  		return NULL;
>  
> -- 
> 2.17.1
> 
