Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751386AbeCLSVJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 14:21:09 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42661 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbeCLSVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 14:21:06 -0400
X-Google-Smtp-Source: AG47ELtlj8ZZfTMMS66z0m5g/Ebu8ZnZJnAOWUh9ZX06Oz9nWSiG8KnzLz4H3ap6gq/yONAvmR7cGw==
Date: Mon, 12 Mar 2018 15:21:01 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Graff Yang <graff.yang@gmail.com>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging:iio:ad2s1210: Rework read/write operation for
 fclkin and fexin
Message-ID: <cover.1520878492.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset changes the way that frequency of clock input (fclkin) and
the excitation frequency (fexcit) are exposed to the userspace. The
original code uses the IIO_DEVICE_ATTR to export the configuration of
fclkin and fexcit to the userspace which is not in agreement with the
current ABI. This patchset adds one channel per clock configuration,
updating the read_raw function by adding a handler for the new channels,
and introduces the write_raw function.  Furthermore, this patchset
removes the legacy code responsible for the read and write operation
related to fclkin and fexcit. Finally, this patchset uses parts of the
original code for handling frequency configuration as an attempt to
avoid problems.


Rodrigo Siqueira (3):
  staging:iio:ad2s1210: Add channel for fclkin and fexcit
  staging:iio:ad2s1210: Add frequency handler in read_raw
  staging:iio:ad2s1210: Add write_raw to handle frequency

 drivers/staging/iio/resolver/ad2s1210.c | 201 ++++++++++++++++----------------
 1 file changed, 102 insertions(+), 99 deletions(-)

-- 
2.16.2
