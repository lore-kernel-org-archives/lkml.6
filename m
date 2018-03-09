Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932075AbeCIQrG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:47:06 -0500
Received: from ale.deltatee.com ([207.54.116.67]:60812 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751166AbeCIQrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:47:04 -0500
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
References: <6717325ea580df9a0294db6f83fd72a5db3daad9.1520591515.git.arvind.yadav.cs@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <81eaa48f-2d47-6e4e-9445-356930d974a3@deltatee.com>
Date: Fri, 9 Mar 2018 09:46:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6717325ea580df9a0294db6f83fd72a5db3daad9.1520591515.git.arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, arvind.yadav.cs@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] ntb_transport: use put_device() instead of kfree()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks correct to me. Thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

On 09/03/18 03:33 AM, Arvind Yadav wrote:
> Never directly free @dev after calling device_register(), even
> if it returned an error! Always use put_device() to give up the
> reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>   drivers/ntb/ntb_transport.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 9878c48..8182a3a 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -393,7 +393,7 @@ int ntb_transport_register_client_dev(char *device_name)
>   
>   		rc = device_register(dev);
>   		if (rc) {
> -			kfree(client_dev);
> +			put_device(dev);
>   			goto err;
>   		}
>   
> 
