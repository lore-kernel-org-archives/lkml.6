Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbeFANcc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:32:32 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:51546 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751068AbeFANcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:32:31 -0400
X-Google-Smtp-Source: ADUXVKKWAy+YuHHBFcqGDU+Guis1rYl4bp+ZlMdRsT2brznG7R4NpY0ZTZB/sey3mj9UdugZ6nbvbg==
From: valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To: Hugo Lefeuvre <hle@owl.eu.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernelnewbies@kernelnewbies.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: add rw semaphore fixing concurrency issues
In-Reply-To: <20180601125037.GA2339@hle-laptop.local>
References: <20180601125037.GA2339@hle-laptop.local>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1527859942_2795P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 01 Jun 2018 09:32:22 -0400
Message-ID: <255415.1527859942@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1527859942_2795P
Content-Type: text/plain; charset=us-ascii

On Fri, 01 Jun 2018 08:50:37 -0400, Hugo Lefeuvre said:

> @@ -805,9 +809,11 @@ pi433_read(struct file *filp, char __user *buf, size_t size, loff_t *f_pos)
>  	if (bytes_received > 0) {
>  		retval = copy_to_user(buf, device->rx_buffer, bytes_received);
>  		if (retval)
> +			up_read(&instance->instance_sem);
>  			return -EFAULT;
>  	}
>
> +	up_read(&instance->instance_sem);
>  	return bytes_received;
>  }

This doesn't do what you think.

--==_Exmh_1527859942_2795P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWxFK5Y0DS38y7CIcAQJkGgf+I0RaQz7bo2XqowH9nGKoLDp5iinEinuf
RhirNWGqRvn8sjQ4jAKB1LKTdQ/XZW8JwMN7ddto5MDFhZS2IbdeY54YXQImgKxd
S579JAY7xhcQS60ItudoxzxGUOMNfcuAiQ+H5rdQhFJIqUaELovNq5T6CNK4TTaD
p9qgKN6uvX5zapzDmMf9V9Rw8BKr98lVy+dLvYU2LHeAe9d/06DFkIuKCHGDvT9G
KBLMMA+yw41d3PDDf8r8galKoPCHCKP60h/7GsRjwtrzEzzTqPXiYaTTpxSNYdt+
QtXJo1xWpD0YzKLFm6kCLqF151bc00qmJpqT2AetYrfnTZHjQE/oTg==
=PovE
-----END PGP SIGNATURE-----

--==_Exmh_1527859942_2795P--
