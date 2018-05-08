Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932841AbeEHWc2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 18:32:28 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37174 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932133AbeEHWc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 18:32:27 -0400
X-Google-Smtp-Source: AB8JxZrtTv/iyrla4uyLa1d4CL7EYrAks4BSz8I/D7yBnuckwzAltCMpydBbxHN4ydEI+1B90+DHog==
Date: Tue, 8 May 2018 15:32:23 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] input: xpad: avoid using __set_bit() for capabilities
Message-ID: <20180508223223.GA129015@dtor-ws>
References: <20180331112143.18768-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180331112143.18768-1-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2018 at 01:21:40PM +0200, Marcus Folkesson wrote:
> input_set_capability() and input_set_abs_param() will do it for you.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  drivers/input/joystick/xpad.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 9d2688f3f961..cbf54082281d 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -1568,7 +1568,6 @@ static void xpad_close(struct input_dev *dev)
>  static void xpad_set_up_abs(struct input_dev *input_dev, signed short abs)
>  {
>  	struct usb_xpad *xpad = input_get_drvdata(input_dev);
> -	set_bit(abs, input_dev->absbit);

The switch below does not cover all possible values of ABS_*, so I stuck
"default" branch there in case we'll ever have ABS_* that is not covered
explicitly.

Applied, thank you.

>  
>  	switch (abs) {
>  	case ABS_X:
> @@ -1628,10 +1627,7 @@ static int xpad_init_input(struct usb_xpad *xpad)

Thanks.

-- 
Dmitry
