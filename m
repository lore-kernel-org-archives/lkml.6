Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0153C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC79321855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ncentric-com.20150623.gappssmtp.com header.i=@ncentric-com.20150623.gappssmtp.com header.b="wWbj/JvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733042AbfBKPsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:48:36 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44450 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732112AbfBKPse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:48:34 -0500
Received: by mail-ed1-f65.google.com with SMTP id y56so9243668edd.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 07:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncentric-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=aU5MNBGnX152eDQmWMpQK2TdiKRA+CVWKKM69YyusYs=;
        b=wWbj/JvRDG0CdZ5ySV9rk2EBoLGCSBEcHg9W4y9vwPfTrV+rg6pTh1VGpoH7mONebD
         uwleVhIPuPHU48kmclLNjSbfzfJrd8Nub6B8tPXy4+lC2ciryffn2FSH8WEkaoBWIV2N
         6VwVl2XNETLVj6GoybSrm8AjJg29qxLINpdIEYYoliY9i92Ib42cVHeGWjZQyJCD1ZMW
         gqmjVIjNUcVri89HG0r/DNuxkoAovUVz5qFRdghBZy7Aw7M/XW788K1IWt+uwYBOQ21F
         qpqXDyr7rDujCNiqLx60ZrUqOZUs6tDhvh70i904sUjb05rYwXUOfqB8GbH7xOn9w6Ov
         r+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=aU5MNBGnX152eDQmWMpQK2TdiKRA+CVWKKM69YyusYs=;
        b=A+7osk79JsG4OSDkCpYFCAzX7UqXlOAybzPn9pdkOfYZAG5AH55nqELTzPxYhFsAtU
         1RRwV3Gl+XiozrmcZh1kFgLqftaaq2iYJaCZQV9ds87gPgVmy2xQco5pAM4Jj95Pwxf3
         PMbUT2uZBb63qnkkMI+4lLxkhfLB/F8ojffo6Zq8J8t4naOGpbjugimMldJOe5FCbi1k
         b38W2HhMT4iuDEbRniX7gG3E8GZvSHxJBXO7jes29Cwx248xhgWeuTm8ryDJWjSDqCpv
         WhvFSGQ7HviLxy/Wtxxd71ovVM3FHpMsfXp13l3s3hQf5Q1DkwClRDTwWpr8hFCFcvKv
         br3w==
X-Gm-Message-State: AHQUAubzGBJ09jr/UI46EpjUArgBIqTTdtebZ7IENyJ+7NpLyir6CL9K
        VCpDZU2Ifj+wA0XVjB1VoaI6HA==
X-Google-Smtp-Source: AHgI3IY2v/FdQRrm/fFJ43BG6BY3Ir6lGoVxQktij5wkPJX7erZ64HvWvWjb+KRArI7exxFBNBQ7OQ==
X-Received: by 2002:a50:bc12:: with SMTP id j18mr29715269edh.50.1549900111725;
        Mon, 11 Feb 2019 07:48:31 -0800 (PST)
Received: from [192.168.3.176] (d515300d8.static.telenet.be. [81.83.0.216])
        by smtp.gmail.com with ESMTPSA id ge15sm2427938ejb.35.2019.02.11.07.48.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 07:48:31 -0800 (PST)
Subject: Re: [PATCH 4.20 018/352] ath9k: dynack: use authentication messages
 for late ack
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
References: <20190211141846.543045703@linuxfoundation.org>
 <20190211141847.541071852@linuxfoundation.org>
From:   Koen Vandeputte <koen.vandeputte@ncentric.com>
Message-ID: <e3740a06-8735-eed3-b427-e924f3e185ae@ncentric.com>
Date:   Mon, 11 Feb 2019 16:48:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211141847.541071852@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11.02.19 15:14, Greg Kroah-Hartman wrote:
> 4.20-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> [ Upstream commit 3831a2a0010c72e3956020cbf1057a1701a2e469 ]
>
> In order to properly support dynack in ad-hoc mode running
> wpa_supplicant, take into account authentication frames for
> 'late ack' detection. This patch has been tested on devices
> mounted on offshore high-voltage stations connected through
> ~24Km link
>
> Reported-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
> Tested-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   drivers/net/wireless/ath/ath9k/dynack.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath9k/dynack.c b/drivers/net/wireless/ath/ath9k/dynack.c
> index 7334c9b09e82..cc0dc966c512 100644
> --- a/drivers/net/wireless/ath/ath9k/dynack.c
> +++ b/drivers/net/wireless/ath/ath9k/dynack.c
> @@ -187,7 +187,8 @@ void ath_dynack_sample_tx_ts(struct ath_hw *ah, struct sk_buff *skb,
>   	/* late ACK */
>   	if (ts->ts_status & ATH9K_TXERR_XRETRY) {
>   		if (ieee80211_is_assoc_req(hdr->frame_control) ||
> -		    ieee80211_is_assoc_resp(hdr->frame_control)) {
> +		    ieee80211_is_assoc_resp(hdr->frame_control) ||
> +		    ieee80211_is_auth(hdr->frame_control)) {
>   			ath_dbg(common, DYNACK, "late ack\n");
>   			ath9k_hw_setslottime(ah, (LATEACK_TO - 3) / 2);
>   			ath9k_hw_set_ack_timeout(ah, LATEACK_TO);

Dear Greg,

No idea if this is the proper location to report this or if I should 
inform stable@vger.. , but:

This backport alone is useless without backporting following 2 commits 
below also, unless the 2 wifi devices using dynack start off at very 
close distance.

Their commits messages indicate them as improvements, but they should be 
considered as fixes.


https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.0-rc6&id=0c60c490830a1a756c80f8de8d33d9c6359d4a36

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.0-rc6&id=9d3d65a91f027b8a9af5e63752d9b78cb10eb92d


It's safe to add them to all stables involved (4.20, 4.19, 4.14, 4.9)

Thanks,

Koen

