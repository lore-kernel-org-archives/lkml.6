Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbeEUUMd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 16:12:33 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:45440 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750993AbeEUUMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 16:12:31 -0400
Message-ID: <bd408cb86db243289ce32d16adea003245facefa.camel@coelho.fi>
From: Luca Coelho <luca@coelho.fi>
To: Yisheng Xie <xieyisheng1@huawei.com>, linux-kernel@vger.kernel.org
Cc: Kalle Valo <kvalo@codeaurora.org>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Mon, 21 May 2018 23:12:22 +0300
In-Reply-To: <1526903890-35761-8-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
         <1526903890-35761-8-git-send-email-xieyisheng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 91.156.4.241
X-SA-Exim-Mail-From: luca@coelho.fi
Subject: Re: [PATCH 07/33] iwlwifi: mvm: use match_string() helper
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on farmhouse.coelho.fi)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-21 at 19:57 +0800, Yisheng Xie wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
> 
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Intel Linux Wireless <linuxwifi@intel.com>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
> b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
> index 0e6401c..e8249a6 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
> @@ -671,14 +671,9 @@ static ssize_t iwl_dbgfs_bt_cmd_read(struct file
> *file, char __user *user_buf,
>  	};
>  	int ret, bt_force_ant_mode;
>  
> -	for (bt_force_ant_mode = 0;
> -	     bt_force_ant_mode < ARRAY_SIZE(modes_str);
> -	     bt_force_ant_mode++) {
> -		if (!strcmp(buf, modes_str[bt_force_ant_mode]))
> -			break;
> -	}
> -
> -	if (bt_force_ant_mode >= ARRAY_SIZE(modes_str))
> +	bt_force_ant_mode = match_string(modes_str,
> +					 ARRAY_SIZE(modes_str),
> buf);
> +	if (bt_force_ant_mode < 0)
>  		return -EINVAL;
>  
>  	ret = 0;

Looks fine, I'll push this to our internal tree for review and take a
closer look at what the match_string() function does exactly.

Thanks for the patch.

--
Cheers,
Luca.
