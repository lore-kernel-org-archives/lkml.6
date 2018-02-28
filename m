Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeB1Iq5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 03:46:57 -0500
Received: from mout.web.de ([212.227.17.12]:59205 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751777AbeB1Iqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 03:46:54 -0500
Subject: Re: [v2] [media] Use common error handling code in 20 functions
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Andi Shyti <andi.shyti@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Utkin <andrey_utkin@fastmail.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Brian Johnson <brijohn@gmail.com>,
        =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph@boehmwalder.at>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Colin Ian King <colin.king@canonical.com>,
        Daniele Nicolodi <daniele@grinta.net>,
        =?UTF-8?Q?David_H=c3=a4rdeman?= <david@hardeman.nu>,
        Devendra Sharma <devendra.sharma9091@gmail.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Hans Verkuil <hans.verkuil@cisco.com>, Inki Dae <inki.dae@samsung.com>,
        Joe Perches <joe@perches.com>, Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Max Kellermann <max.kellermann@gmail.com>,
        Mike Isely <isely@pobox.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Santosh Kumar Singh <kumar.san1093@gmail.com>,
        Satendra Singh Thakur <satendra.t@samsung.com>,
        Sean Young <sean@mess.org>, Seung-Woo Kim <sw0312.kim@samsung.com>,
        Shyam Saini <mayhs11saini@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <227d2d7c-5aee-1190-1624-26596a048d9c@users.sourceforge.net>
 <3895609.4O6dNuP5Wm@avalon>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <783e7eff-2028-72be-b83c-77fc4340484e@users.sourceforge.net>
Date: Wed, 28 Feb 2018 09:45:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3895609.4O6dNuP5Wm@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Ozmyh7TDnF4lE3X8p6BBPK+j4U4V97gsvaWkfWwx8gEbSiouh6w
 WN8Nu1wJq6s6aZ1zl1fCxNzocC+C+ERZG0fakUzozi0IzAjSTMJ1scIZXXtqf6C+JraN/6a
 xp3FcVsowAQyWhCF1cnHfcBJwUGRTu8WJjHPAapqLADhsf1LU7ToWjXBDIaGqN3B6dL3FRA
 mahyoptwcIPr45zBwLBdQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XUDhxBj9rwo=:A5aL3OSZd1QApmMOr86vh0
 nPyDxWcWNryT3miPgPLsd7q1TN0Gm6bPKi1EKVE/TP834/m+B/6zaJZG9wwNsDIbU9KDp70NF
 hKZb3qXOwkBDo1I3UhS1eCgXvheIw8NEc6+xxbqXkKGPhdRdowaeGOn9enGiTNR3VMSF+NK10
 2/lYp0mq/pHJND7UPbVR4Eculdv9v7RGhTUrre6T3oOCE1rQpaGhHUF6cP/x9vzMEFH7C++yt
 6ZQdDQut7HbNrg8ei8/N2mhKZHPZ+wAS2eb/zDXGSRAFTpI9irO6mFK6F07PR7wgb59knkEzd
 0jsUc0gSAJ0dv1dSybfqmeuv3LZ4DTeBYb2V0YdhuPoW5Bf0U+/qMFoXrZvZvo3H84PgxqL1l
 PACLzMdmVzKi/Y9fSfGpwTs5Ak06+Oeiu5WB25Vzn8VwRUllavDasxV9cVVR0L2Ow3bdV1IlG
 WCmWNPKkp651pSX8PRyemu+ceDuLgwnfu4VUp2APjcaS9IwC2CqSrw60ty28cOBvv5WY4+9gI
 1ftjwprT67U5pY91gOpN3PY5/JxjFJJ0rY6PjqeboynNnuwzxsg1PYXfkLrkfjliqovlm8d+O
 hb5ZV5L7O8YagHlcM1XRDbZKJbuCU0TnY/zKgs2CMFtP7l3C8L6scJPoJUdPEmJ05GlJj1p7+
 ZZujta9jqLw3/G+CJd3zFK2GyGkAxD5clfeekKYDq3HaexB8XVrXbLf21xatwjFnANhtzgY5H
 lJ3AdLO+PV8d7HF76UDWJuFYPkhk2VVD2ctU+gfmP8TpNqSemC+tEm9k20pboCf8Q5CIJx92z
 j8ylBD+bNVOHNUHWZOxrsUKsglnKQnl8qTV6p8FEyP+7QQCwFg=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +put_isp:
>> +	omap3isp_put(video->isp);
>> +delete_fh:
>> +	v4l2_fh_del(&handle->vfh);
>> +	v4l2_fh_exit(&handle->vfh);
>> +	kfree(handle);
> 
> Please prefix the error labels with error_.

How often do you really need such an extra prefix?


>> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
>> @@ -994,10 +994,8 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file,
>> void *fh, struct v4l2_queryctrl qc = { .id = ctrl->id };
>>
>>  			ret = uvc_query_v4l2_ctrl(chain, &qc);
>> -			if (ret < 0) {
>> -				ctrls->error_idx = i;
>> -				return ret;
>> -			}
>> +			if (ret < 0)
>> +				goto set_index;
>>
>>  			ctrl->value = qc.default_value;
>>  		}
>> @@ -1013,14 +1011,17 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file,
>> void *fh, ret = uvc_ctrl_get(chain, ctrl);
>>  		if (ret < 0) {
>>  			uvc_ctrl_rollback(handle);
>> -			ctrls->error_idx = i;
>> -			return ret;
>> +			goto set_index;
>>  		}
>>  	}
>>
>>  	ctrls->error_idx = 0;
>>
>>  	return uvc_ctrl_rollback(handle);
>> +
>> +set_index:
>> +	ctrls->error_idx = i;
>> +	return ret;
>>  }
> 
> For uvcvideo I find this to hinder readability

I got an other development view.


> without adding much added value.

There can be a small effect for such a function implementation.


> Please drop the uvcvideo change from this patch.

Would it be nice if this source code adjustment could be integrated also?

Regards,
Markus
