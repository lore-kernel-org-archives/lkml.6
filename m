Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbeEOJez (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:34:55 -0400
Received: from smtp113.iad3a.emailsrvr.com ([173.203.187.113]:36993 "EHLO
        smtp113.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752584AbeEOJex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:34:53 -0400
X-Auth-ID: siepeng@mev.co.uk
X-Sender-Id: siepeng@mev.co.uk
Subject: Re: [PATCH] Staging:Comedi:comedi_compat32.c: Lindent changes
To: Pratik Jain <pratik.jain0509@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180515052039.12828-1-pratik.jain0509@gmail.com>
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <91b1c34e-02b9-81e5-c37c-4d68b1ab2273@mev.co.uk>
Date: Tue, 15 May 2018 10:34:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515052039.12828-1-pratik.jain0509@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/18 06:20, Pratik Jain wrote:
> Recommended indentation by Lindent on file comedi_compat32.c
> 
> Signed-off-by: Pratik Jain <pratik.jain0509@gmail.com>
> ---
>   drivers/staging/comedi/comedi_compat32.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/comedi/comedi_compat32.c b/drivers/staging/comedi/comedi_compat32.c
> index 97fb9388bc22..fa9d239474ee 100644
> --- a/drivers/staging/comedi/comedi_compat32.c
> +++ b/drivers/staging/comedi/comedi_compat32.c
> @@ -34,7 +34,7 @@
>   struct comedi32_chaninfo_struct {
>   	unsigned int subdev;
>   	compat_uptr_t maxdata_list;	/* 32-bit 'unsigned int *' */
> -	compat_uptr_t flaglist;		/* 32-bit 'unsigned int *' */
> +	compat_uptr_t flaglist;	/* 32-bit 'unsigned int *' */
>   	compat_uptr_t rangelist;	/* 32-bit 'unsigned int *' */
>   	unsigned int unused[4];
>   };
> @@ -57,16 +57,16 @@ struct comedi32_cmd_struct {
>   	unsigned int scan_end_arg;
>   	unsigned int stop_src;
>   	unsigned int stop_arg;
> -	compat_uptr_t chanlist;		/* 32-bit 'unsigned int *' */
> +	compat_uptr_t chanlist;	/* 32-bit 'unsigned int *' */
>   	unsigned int chanlist_len;
> -	compat_uptr_t data;		/* 32-bit 'short *' */
> +	compat_uptr_t data;	/* 32-bit 'short *' */
>   	unsigned int data_len;
>   };
>   
>   struct comedi32_insn_struct {
>   	unsigned int insn;
>   	unsigned int n;
> -	compat_uptr_t data;		/* 32-bit 'unsigned int *' */
> +	compat_uptr_t data;	/* 32-bit 'unsigned int *' */
>   	unsigned int subdev;
>   	unsigned int chanspec;
>   	unsigned int unused[3];
> @@ -74,7 +74,7 @@ struct comedi32_insn_struct {
>   
>   struct comedi32_insnlist_struct {
>   	unsigned int n_insns;
> -	compat_uptr_t insns;		/* 32-bit 'struct comedi_insn *' */
> +	compat_uptr_t insns;	/* 32-bit 'struct comedi_insn *' */
>   };

Those all make the code look less pretty because all those comments are 
nicely aligned currently.

>   
>   /* Handle translated ioctl. */
> @@ -194,7 +194,7 @@ static int get_compat_cmd(struct comedi_cmd __user *cmd,
>   	err |= __put_user(temp.uint, &cmd->stop_arg);
>   	err |= __get_user(temp.uptr, &cmd32->chanlist);
>   	err |= __put_user((unsigned int __force *)compat_ptr(temp.uptr),
> -			&cmd->chanlist);
> +			  &cmd->chanlist);
>   	err |= __get_user(temp.uint, &cmd32->chanlist_len);
>   	err |= __put_user(temp.uint, &cmd->chanlist_len);
>   	err |= __get_user(temp.uptr, &cmd32->data);
> 

That is the only one that is an improvement, IMHO.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
