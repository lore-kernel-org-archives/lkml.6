Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A16C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760932133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760932133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeIMFrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 01:47:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:50322 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbeIMFrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 01:47:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 17:34:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,367,1531810800"; 
   d="gz'50?scan'50,208,50";a="262129360"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by fmsmga005.fm.intel.com with ESMTP; 12 Sep 2018 17:34:46 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1g0Fao-000629-AY; Thu, 13 Sep 2018 08:34:46 +0800
Date:   Thu, 13 Sep 2018 08:34:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     kbuild-all@01.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v3 10/21] nvmem: change the signature of
 nvmem_unregister()
Message-ID: <201809130842.7chpMsT2%fengguang.wu@intel.com>
References: <20180912075129.25185-11-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <20180912075129.25185-11-brgl@bgdev.pl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bartosz,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.19-rc3 next-20180912]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/nvmem-rework-of-the-subsystem-for-non-DT-users/20180913-071053
config: m68k-sun3_defconfig (attached as .config)
compiler: m68k-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=m68k 

All warnings (new ones prefixed by >>):

   In file included from include/linux/rtc.h:18:0,
                    from include/linux/alarmtimer.h:8,
                    from include/linux/posix-timers.h:9,
                    from include/linux/posix-clock.h:26,
                    from drivers//ptp/ptp_clock.c:26:
   include/linux/nvmem-provider.h: In function 'devm_nvmem_unregister':
>> include/linux/nvmem-provider.h:101:9: warning: return makes integer from pointer without a cast [-Wint-conversion]
     return ERR_PTR(-ENOSYS);
            ^~~~~~~~~~~~~~~~

vim +101 include/linux/nvmem-provider.h

    97	
    98	static inline int
    99	devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
   100	{
 > 101		return ERR_PTR(-ENOSYS);
   102	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--FCuugMFkClbJLl1L
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICNGumVsAAy5jb25maWcAjDzbkts2su/7FSqn6lRSu87aM47W2VN+gEBQwookaADUzPiF
JY8VZypzW0mTxH+/3eANIBtSqlLxqLtxazT6RjS++9t3M/ZyfHrYHu9ut/f332Zfd4+7/fa4
+zL75e5+9/+zRM0KZWcikfZHIM7uHl/+/OfD/P1vs3c/vv35xzev97eXs/Vu/7i7n/Gnx1/u
vr5A87unx7999zf47zsAPjxDT/t/z7DV63vs4PXXx5fXX29vZ98nu89328fZv368gK7evv2h
+QsaclWkcllzXktTLzn/8K0DwY96I7SRqvjwrzcXb970tBkrlj2qB0v9sb5Seg09uAkt3Qrv
Z4fd8eV5GGmh1VoUtSpqk5fDaLKQthbFpmZ6WWcyl/bD5QUuqx1T5aXMRG2FsbO7w+zx6Ygd
d60zxVnWzejV68PL4+UrClezyqph0EUls6Q2LLMfXvX0iUhZldl6pYwtWC4+vPr+8elx90NP
YK6YN3FzYzay5BMA/sttNsBLZeR1nX+sRCVo6KQJ18qYOhe50jc1s5bx1YCsjMjkAn73TGIV
SI/PHbcPsC+zw8vnw7fDcfcw7MNSFEJL7rbNrNTV0DHTfIW9gzwIa2UuVJoaYb05ayHy0taF
KkS327ys/mm3h99mx7uH3Wz7+GV2OG6Ph9n29vbp5fF49/h1GNpKvq6hQc04V1VhZbH09sQk
MIDiAlYOeBvH1JtLf/WWmbWxzJoJBzSvZmbKARj3pgac3wn8rMV1KTQlZaYh9pubUXu5bv4g
ZRQFLgVmy9R+eDsfuCkLuwYpTMWY5tI7AEutqtIQ/aKMmpIBW/yJVNbURUA+zBGEM4KCXdcx
XCmTGKoQNobiK8HXpYIl1hrOrtKCJDNAl7jT6dZJ09yY1MDxBPHjzIqEJNIiYzcElxbZGppu
nJ7RSah3NMuhY6MqzYWnCHRSLz9J76gDYAGAiwCSfcpZALj+NMKr0e93/j6BklUlHDL5SdSp
0jWIHvyTs4ILYhVjagN/BJonUB8MDigsUCVONFrgim1EXcnk7dw7WWXqzyl6AEbNclCTEkXG
mwKojBwOopsLy7JgcsjkMThdsSLJJgoR1Y42vsrBQ+Jrbk9liCwFA6G9ThbMAIOqYKDKiuvR
T5DpEWMaMM/La77yRyhVsBa5LFiWJr4ygPn6ALERhfUBZgV63Nsb6YkFSzbSiI453rKhyYJp
LX0Wr5HkJjdTSLNsPAFWbkSwvVPG4745Q+cmOex9vhBJEh4up0Rb36Pc7X952j9sH293M/H7
7hFUPANlz1HJ7/aHQbtu8oYHtVPxwWaiMWcWPAFvQ03GAltmsmpBqWAgA67opejsdNgIsClY
p0wa0DcgWSqndZlWqczA7hBD5PP33rzQTC2QL0UiWeGd5Csj8t6ImlIW4Gd47TrM6krI5cpO
EbAbcqFBj8FCQGWFogSG4Ar15QAtVC1VqbStc9/7AHDi659PYJJDyOrTh7eD71YuLVuAH5XB
3oCgXfSLzj3LBj9qUxWXnoSJa+G5OAulwPqlypnjzgMo77dHFI3e4Wug+6fb3eHwtJ/Zb8+7
QTyQy+BIGiN5oA5VlqRSU7oPWoAX2o/W92ued7d3v9zdztQz+sOHxh0ZRklhB0VekXIABw81
bUJJGkgHMKp1vviqKkZSsWLghiSJRnekt7+ddimrbqL59vbXu8edW34wN5bLJaNnZZmWJCZn
nG6B+kmRqE1OW9xVefnmDW1nYeuvSczHd28oTjWi4ta2eDmAq/X8/LQ/dhLQKo50tz2+7B0L
QnH5svv97nbnaQ4UKuCuTq6YHvzLX7f77S2oGI8+CDO2e+DzcXeLg7z+snvePX4B7TR76oWi
96mZWY3MhRPvEcx5wVcMFBj6SyXToFq7CGOQA+7EANxOcHK0soKDh9P5xb5dyVXS9GhKwWUq
vcMEqCoDZxsUsrNkqL9PYgekwuhFLk0FvRbJ5QTBuA2m62ZQqM6BDxxfkTpF7azmRPkvudq8
/rw9QLj6W7Odz/snCFwDt77MqqUsXNwEceSrr3//++BKgdpCy+qfEWesTI5G6c1otf7EGhB6
OxzVIqPOaktTFYiPNm7Q9LlSSbu3tBfb9gPefh9IhlyaUIYhwBiNFhAVB0ljtcxhsrDjSb1G
u066s4G1yRYJSz3WgrNruJGwqxBYGhti0A1emCUJbCLKic9sxVJLe+OztkOixaGZihQ8T8DM
iub86CjZ1cJGccgGVbKpUJbb/fEOT3evWztBZNpK63ap1e9BlAznvBhoaH0KLuhpCmVSmsLX
7gOFdwZRuVMI0O0k2CTKUAgMhxNp1uDz+Dohh4jmGnTygmhiVAaDm/r6/ZzqsYKWqHODbvsV
Z0l+hidmKc9QgL+mY6wdrEkwt77tmkFYdKZ/kUZmMAQhm/l7un9PVKftm0yKmpnbX3dfXu4D
T1eqJnotlPITWi00Ecz1++FhjOHpx4G8yzo1wH5SHRj7JtbTodsuP7y6/eW/vdLNP56YhIdc
3ywgvphMbwEz6YHMFG89ksJxCr1ep1X5GtNIflDt8BpGbfGncGTbK9A3ItbYR7at3QaJP3e3
L8ft5/udy6rOXKRy9LZqAV5rbtGQBtFja/k9LxQPQZWXPYPR9K5gyqD9KW3cdGu4lqFVbREp
RGREM+cZMFX5+rlp4IAPI2AuDR+AOEecYu9n7h6e9t/A3Xzcft09kK4PTiMIQhFQY34A3dxR
YCFABFyAX4K9onIIGJuGu+PcC9AdHHw3Ag2OBwYOwQxMmUlbl9btJHjV5sO7MOnbuDAUz8Fb
4Z6btZHgZFgYogrch7XJT5ybHNaMGtM58h/evfl5Hqy/FNq5+mtvxjwTYFIYHBF/mFSrwmJi
mE6C5YyYxKdSqQw2tCf7tKhoS/rpMgWPjkY5D0rRYYFMMtRnECxbDR7qKN4domGhcZWT5GlP
sKzKeiEKvsqZXlMpSD87jMlAGAndm042i93xj6f9b+AtToUSdngdJJfdbxAjthyEHS1TaKdG
BBaCWY+T8BOdE0km0a5T7e0n/qpVmrauow9l2VL5m+yAVcyPcVh0lXTKOB1zORIwzTWEa5JT
aUpHAa4DJgYmQ+MGSWMlp3RQM3yJZ2ZgC+7FWgR+WwvqBqF6SkrwFHAXjK95RaDZZNloB84M
7boBQed91RrUWci1gcjh6iYV4Odly7osyvHvOlnxKRC1yhSqmS5HUlnKEW9kuURNL/Lqeoyo
bVUUIiPoB5C5KUBJqbUMMjWObmNl2LRK6C5TVU0Aw/CjHajZyrfCABCmnEJ6eQ4xY+lwQCc3
44k5DAlsBBRNBqiUwmBGKk5xuoOFEOO24aFuZsFLCozsJMCaXXXgQRK7nmGjjdXqhpRXHAf+
PJkT6ml4tfBD+M6cdHjww14+392+CnvPk58M+WUIpGXurQN+tScGA/U0PHUdrsb8W+TgAU3z
lQB1RZ2QITMyZT4Rp/lUnuZxgZoPEhWOnstyHllnLTM27iUqgvMI9KwQzs9I4XwqhoG4+HjH
7varC4s4I25lwZF3ECPthDcAq+ea3BJEF+g/OX/L3pTCV2obghsIDDSSgwQqpYMMjUd71fl4
LjEc+2KIhI4RcbwRy3mdXTXDnCFbxRKZwHu8QwBUPO5rgL9YthYjHds217pc3bg0OhjMvKSz
/ECaysz6H1Z6kJ826LxNLRNwo4ZWD92ti/0O3RsINzA3Ob6ZMel5cIwmKPgLgpt1YAxaVMpy
md20k6DatgRjixf23HxOJ7rv8M3VhBMEmVqeQiuTemj8JlcUzvEMoPiNG7RGDtH3GAwdgddG
DYFdufwkPUCNwuIt3UdhgioICQIsJpvTyFdtn859y/oLdO6+REW7RBNCJ5+UcPqELhEzWYDF
mUO4k3Ae66EjCRSEjzDcd5t8DFhXiMtEhKMsZ0XCIjuR2jKCWV1eXEZQUvMIZqHB7KCTGcGD
iCykwrsOEQJT5LEJlWV0roYVIoaSsUa2Wfton9rTQW9SwcKFFRiQQ+jp654WHN+ZATvZUUQR
24Xg8UYhbLwPCBuvF2GWaqxFIrXgllJB4CnDDK9vgkaNxSFAtRGWAssw0Ozhrd7wMMDFKl+K
QMXYOlB/KeZl1NXUtXGUzUfrMbAomqtpATjUigiY0uTMfAwhjlshqBEGT3w6H5yUHVurxX/Q
Pwz6GOtwB1KWjQf/jxgzo4E1PB4tGz/Xh7AVM6sRL+ViAiA6awLL8TLBckQ0JrDACQ59fJKq
nBoNaBODp1cJDYe5TuGNfDQfzMcr8XCUvbruZdu5CdcuKXmY3T49fL573H2ZPTxhFvlAuQjX
trFmZK9OBk+gm4MTjHnc7r/ujrGhLNNL8KjcNS1T5ZFuO6rO5zpNdXqKHRXpigz4xPDyNMUq
O4M/PwlMkLmrO6fJIn7PQHBipFDDE20LvDF1ZqlFenYKRRp13zwiNfbHCCJMCwlzZta9sj9J
BR2dIRhbBYoGpnyuG17mxpylgSjOWO3sWXBEHrbH219PnEbLVy5D7EIyepCGCC/SncLzrDI2
Km0tDfjGoogxtqMpisWNFbElD1TNZ7yzVCOLRVOdkPKBqBMwPyib0JXVqZBsIETv9uSIoLHd
hdHTRHFV0hAIXpzGm9Pt0RqeZ+FKZOWZvY+qtAZNpHenJJoVy9NSml3Y051kolja1WmSs8uF
EP8M/ow0NZmJILdDUBVpLKztScK4lMBfFWf2pcnXnyZZ3ZhI8DrQrO1ZFTL21qYUp/VzSyNY
FjPmHQU/p2VcNHGSoHPmTpBY/JJxjsJlKs9QaSwTOEVy0gi0JGDrTxJUlxd+6iwMRJrfQHn9
4eKn+Qi6kGjGaz9YGmOCExEiRynMBodqheqwhYcHKMSd6g9x8V4RWxCr7gedrsGhogjo7GSf
pxCncPElAlKmgc/QYt21YDNK95b1ZloyIst//4W0XoqZf81cZvNdEB00J2MKb/wdAt4GuAgP
wli+YrLoUv6jVkPMNkFgADSFupAsMnSYOwxjn3ETqneXwMNOxrAJYWTSTQJiMueGARTOATGw
roRmiSCYh0iSa+C70t1htghvJsppHoROpjnMOI+EwDDbBVIGcFmOUx4NvPUwVzQ88E58hC77
ZDSBtTYbI2jy3qMPcwIBcpq/adBBdBO0GDYmQjCOe0aTGYcX3dLwVnakUetdy1inBCO72GDK
K82uxiCQbnr/WGwnADFMuVUsv8//mmoZVMg8EK5BhYzgvQqZn1Qh8xPna4Trzs88cn4m8O5g
jxCtvhhBW20UriJUOyGO6iY2aKd6QiC1TEKNzP3vbvPYyZ3Hjq6HEJWcv4vg0HJEUBioRlCr
LILAeTdX1CIEeWySlPT6aBtBGD3tkcjNtJjIGFHt42Mp9TOn9cGcOLxzQlX53dO6yqcoyjD7
N9h98hBOvtSltvuEOE29NlWfTYse3H1wTGuxGIteiwMEfh6p7LQZouyE4wEyYIeHef/mor4k
MSxXvgfuY3yz78FlDDwn4aOY0sOErq6HmERUHs5YevhNxorYMrQosxsSmcQYhnOradTUivnT
i3UYpPo8eJcEHG6XtueWvlgV5k6aSzB8uEzjrJH7esi5TA4TQ+Q7yK4dkl2A4C8q+hahT3dJ
T6kNKL2qXwuNFkv8ksELsuTaUXR3o91VK3d5AC/TBJV/MTqzYm8jFceRFli9E5vJdAYxLI47
urvVjBjcWdKJCX5gDOszCEFxjkMUFykHs9Sl1zbtM1zoh9/1htoq4uRMJFIuwVM2eC89KN93
V4OdrBk2vnYIILpEDQ4k6p23H0l0An6bIF99yHiwnoxfUJUYlmVBQhKrVlhZZgIR9D3Ni59I
eMbKBYkoV4qe4hzcmdJXNy2gLlacBLo7ajQGLU6YGfaxK1XSiNBG+ZhcLWSGZT0kFi1LkHLx
kVVCjLYEhLgG459oejrLUy0lz8mZ+r3SzPEpQqeKougs5qC4hBAofT+9iz5u4CoiaOHkVJly
Uhgs31X47ohf8QYRjytKCrR4D+3+3FDX3T0qvz7QgyfMkvCCk+Dc3arwjqgqRbExVxJcO/qY
tpeC6dS9uwEUare8zEb3YhFSL40Kaaai5qDgcxP3ZQv34XkoYzX0bWy3a24tcNwj18iyS/T8
MP/X3B4I37PgRkba6WusMripw0cBFh+DcilXdG+1YDlR/Obfip8dd4f2fZRgAuDaLAVd5rRi
OTirkr7/yRndKFJix8BbvtahIRlQa+5lkYPl+JtwBV5OFitnvJI5o8uJdbqWkTJKZMDPkWIK
JunLAlyU+F2C1tBFSq2wNAxELUwJ1zL1AN2FRq/WsoW0r2Z0J96AF9FWhbSgpVYwp2x8BkDW
wnt+Obtx5b0DYigrYTJTG0J2ElcEPUv2d783tWhDLfTdbQumCuKr5k2G5lMUWRizsXmZelPu
IGAt8Prd4PFYvFWUBaXO4D677lOpc1dI6B5Y6qpA0rv9wx/b/W52/7T9stt7dUlXrrDXV5Wg
rDXr+8FHWQaedNTNazXRpWBZzJUz9l6pVOc5gR2pGUSVYG+13Lib1mrhbXv/SkNZtYUkfTEL
lrhPatbhn8IVf/u7tywiRyK3tDFRtGDDgcNkN1kGvB7rrq4ut6iyDH8QrXiilVcB07XIgvpF
H+pKpJrrl+/HeK5vSqtc24cxLtGLJPC84HfdViwWGAZHSru6JSySaZ+aEVMHYDu/4V0lH+fe
yfHLuxwLUMXyZOMNEoDxJaYUHy557+mYgODKnXja56zx3NbCBtaqn9Ni+sBKgS81DG8nDJoL
4G0aYtImvzvcToURZD2/cXWR3tCi4JkyFRxKODVOoOmwCNhFa9eLsQw2JZcCTk4+O0zn3WDq
ny/59XzSzO7+3B5m8vFw3L88uFdkDr+CavgyO+63jwfsanaPr2Z8gQXePeOfnY5jmDbdztJy
yWa/dBrly9Mfj6hV2ntVs+/3u/++3O13MMQF/6FrKh+Pu/tZLvns/2b73b17fe8QPlYxkOAx
b/RohzMcDM8UvFElAR06Wj0djlEk3+6/UMNE6Z+eh4dPjrACv+Dze65M/sPYKOD8+u6G3eEr
RQiuC99kEtSewc/J/uHrAq3geSzsZAifHsiVd4VVM5ngA3baC3eRyg+gsc1H71UfH+GeBEl7
FexGb4edHb89w4aDoPz2j9lx+7z7x4wnr0HyfvDKfttjZ7wp8ZVuYF5A0cGU8aF9az1VPEbX
YPESpYmOg1xNDw2da3+R8DcaVRvc9XaYTC2XseJNR2A4OvVoz+idst2pOox2yZSy3ZfxmClv
ELHZSvd/Yk9rgw/jtPDRNAEDDhr8c2Ipujw9MFh193qRl11xcBukuxwICwObh8cmU5lkVTpk
VVx2ojlqQUdFDqdM4l6SkwxcgEhKhioBzpOpSOWePcqTGgvemQ5AeJreTCBvp5Ap0buf5j4r
8q7Gm1l6dXlrr+maOcC239zoiCNmHnv/IHceIsR+UzYkeeA55J5yoAPxPLqnbphUqlGHjrx5
SQW/I7Al2Gv8QRcMYScSn86Rxq9cwUcx8EkYYAI4vhCCswBXFe7CoUgCqPOZAogpWGlWKgTa
FbhdoPo2Ep+caQJkfwEx9gLKvZDQxCN+j0KH08ul1qHPCkD8HIGutXvUiu4eRSno6JPQKuy5
E6vxLnbw+iMd+QU0kdpit3n0O4/IcxeEBK9o5PjUwVrQUgxYcNVkRMZxcyY5kZBZjtkmWP7w
ZE4P7W9H+zcILAfa5p2EAJbKTEgVwkqnlvyEJzjdC1d4MvEOB+Pd6MYJwf8Ye7bmxm2d/4rn
PLUzX9vEcbLOwz7QEm1zrVtEyZe8aLKJu/F0E2fsZE73338AKcm8gM55aDcGIIqkSBAAcTkp
pCf1xlBS3YwYkzyLA/sChc1TR/ldzRKQtm1/OlC4WOpD2gBMIsTHIihBsge5eyKyIIVK9RfC
Yg6JJceZchxFDRpUKScswbA/UzOP7MsiBFS204JNgIHfJn65ttCoVi5NNdM0tEPjkttecCgS
5I59ooU18SZjqRmFrHyiTIuUsiIBBCWLqoQ/TA27qjNzbVo3A4BrlmoZqATECcUFlo5qkyUp
kTJHGWtOMv2TLZrGO5D/d98/UBCX/929Pz4PmJHGzSDvVlc152VmZyLAfmoZDFR+FinGRx9m
JmXK7knd06Ix03eCXKBXR+DVsO4zOP8/fXFJ2aFMgho4MrM/YouKWMytnCcWbinqNNC5CD3+
MrpvcRbgHMbz/D6aC9oaZ1DNa7biIZtpSyPGw+v12p7WBmDjG3JUyEaTwKBSVoIUGDYfdmQi
KgPxyA5VLnlKp100CDNW/U9kHDZclgdyL5qEnzaFDBVjAj6jK4G3hCRrkwyN+GGbeUslWQqf
htY4TDLO6Ts7kwaTjsHxG8j8bFFGIOfw9afrUVbqe31KVtOWcJNkk+UFaAif0S0/39krcR/a
SmkMkqOfj8a4Ptw4dusOURjnA/zApG92CAACQSxOLC9rBLrR7QhLi8K6+VIwFLYCAaqAz61m
K/vNuR1JgM0pJdQGKTNrZYpCMjE9Q2Ri3oUirs+PaIbBKoSEXV85MHV+4183nX0ATS5/HHdP
20EtJ72hAMe33T5hyYX9QWG6Gxj29PCGzniEFWuVMP9U468qx9hqhzcbv/nZjX4fvO+Bejt4
f+6oTkfZqenARQ2uKcrwb8h0MZGc7vXt4z1okhFZUdv5exDQTKeYpyt4daOJUIRwLtEcCqmu
hBZpIP2VJkoZ5v5ziVTf6+P28BNrBuwwifTfD492ptz2+RwzYp7tx7d8Q9/2aTRf6gAN5ym+
dNRGYz69exbrSdAoJjkrrfSSHQw0/sWENvP3JMniU5KMr6pAssOeBi9uUWCnP2JPJqt8xVak
1nSiqTPoEjmetTse/+uYzykA6CyUS4bGgYopmJWQRMO1b0ZeB6Q4TTSJ0uvbL/SNvaZYyvV6
zWi23XYAJOgC02k1yAzOLiuMT6F9RTSJctELaGCaAMcjQRQJXOm2swjqGn1VmoqRUsq8dTp/
ODwpG7j4Kx+4Jj6YYSPNvPqJ/1ehE6Z9SyHgCHI+l0NQstUZLMPzhrlf3CECbBqy4LTNlFFg
1dR6OOYFG0s5eStBZYvudJvKyLW+NM6STq9SKYUSlelHmpQdgeHrtPJhQHcCY+bG2HKPwtR1
t+OmqDaWxTXhMxZtFDg4NSxB1zR97VrSXCNrZpKWE1UMLeY0p4554Io6KeNJKeDLBYB8Y/L2
sHv4SR1mbQ9BlL/wnsr2r38oxFE/rk5j4qxt26jhiMccF+dmQkZRtg6UCdEU7XL8VrEZNvg/
kH5KVtJ7s0WrDMp1KIFSKhpd6YI+0mHNnClXUF7d3tCsTuU7UzfY9GeP4L/C/45iGFEfAMHk
CAtaS5FFQBOak74zRSFt6ZNwbuxWclUo8i7bfyEHjz93+qLQ7ze2FCUCLbALFc5Pv7yjSWKd
SZV6flbYbjX969uCXfvD0b0zBKkYOrd//McXuzBR1eX1eAytaxOfKT62Uj/KPVkocZUhRz48
Pals17CB1NuOf1pTILKoKmk9F8cU8otZ0d6xRb7CPFjLQCkghQWBI3Dkabys4SCnjarzVRoQ
atDAkzJ6HCuMOohzX1ZLP36+7/7+eH1U2cBbGZhgUuk0BjE0hs1O96rCDNxSRFckGp9e8LQI
ZGJVjVc3V7dfgmiZXl/Q880m6+uLC++Et5/eyCgwa4iuRMPSq6vrdVPJiMUBOYLP6iR4SVVG
Z3rAY8HUN6UO3Nnh4e1590juzrhMmxh0Ou5fTrKoGPzGPp52+0G070t6/E5XuGNpPEh23w8P
h1+Dw/7jffd6qgIxPTy8bAffP/7+G8782D3zp1Zpmd47CUZECbTTSZcL/HRuAyzLKyfdHACn
MF1ilrXlYciJAyqloWpHJXpDAQ0o4XwCx17lmNn94T13Eh+xwqGheskDftaAlJfx5RXIxSG8
mKTNbF2NrgO1QYAEEy3XgR2KYz1r+QICZe6Xcx7gHdhJgU55JBaN+AkW1GmSKA6uRlg+x/1P
5T3y9vPhVztRPnvWjjKeDGeBsSRNnYIoOL6g8WW+kl+H1/1KKUEo1Z5DRsun4floOASxcAhe
LaaspBkm9ViZV14+yk/eA79KDqyCLbhrXegk0XxmaAz4C2+g6zWs4YxGLGfMLApmYKKkroZD
q9yZxKscX4eBfeh9nLmwfMfgJ3ovg6S2UY6omKGC6D+QYfDXSeAmmmmd+3zpFisJwfGK3fGu
HvBBNsK7Bbc5FpX1mu6K1mW9B2pMzxB4YsKThXnRhbAIDsVy48IE/Nq4bUd5PWMBGRPRio0H
Xh1tlNHNbRImdJZnpZCBQkJAwlPZTGnnRYVOeJRTISkKeY8Zqr1PlE5EQMtR+GlJi8qIhPbC
5gNFsAkPZQXaQE5rFurFmzK86ZBA4C1NGBtQaxD3jU1Cgglgq5XI5oy6stJDzrBgVaVcE6zn
kkhJY8F2E57lS9IVDJH5TFBLvoM38bdwwx0N/CjoCe1JAmsH8WWdThJesHh4jmp2O7o4h1/B
eZOcXaMpm4lI2YXOkGymCZPhdQW8Ve2VwGzqS6Z8Wtk7GTgrcDV/DyjL/PmFnFUB/QtwcDBy
2mSF2IJlKGon+ZlNVmCE1CajhQVFACwIzuEwPmF48Zw5GettmjIYH4BoycS5YZy7p1L4gvPY
vd2wKdAH4BwW1g2cFgHjqqKpsyIJKP5qVYSUZGQnaBAElSO879WNx7d8c/YVlVjSt2EKmReS
B8KXFH5e1rLSkTBBohqP1aaQtGqEFGuRpeFOoIPQ2SHcb2I4SM8wVgksTt0y04qsOlgTskJu
LSdNPo9Eg+I1yEFuLUfEt6KkDVQFTbDA2zyybOKOuVjfYQCM8nFAePH864h1vwfJwy+0Sfpy
e5YX6o3riAv6hgOxMxaH/HwwCppW+fDBOilE0DhVr+gZTVO6wRRO+6A5POMrOFJi+k0swuLN
QkcdEh+qBAXcqkCGAJV00gbNoyqXGxrY3rN+/c/h/fHiPyYBICtYBvZTLdB56qQRV9GZAFzE
onu+b2ADjH2ZZTwhsmraeqX+8uBtRU0X7AR5mPCmFhwLXNIamRpAufQKp/dmQOyps2TR3BcA
o7Eq8FRf0NHGeT2J5eVwfHO2s0ByfUkbSkySa5oZGSQ34+s2N/pnlF9G9LXFiWQ4ugjYYFsS
WS0uv1RsfJYoHY2rT0aPJFd0ALJJcn17nkSmN8NPBjW5G40vzpOUxXUUsFl1JMuri6Fv9N+/
/oFpHu3F4DzZKmJWxHuLmlbw18Wl3y4qZ3L7igEQxCKMUwZKr1Fl6KR5ohcCulXSnKlex0IW
jk/piUUGYi1V0Sltf6c5HhKIHFhmVnsjSXePh/1x//f7YP7rbXv4Yzn48bE9vpM3IxULBgDM
V131YZpbM5FMclrAErku9UtbUcrty/59i/Em7iyXby/HH+QtEKr3K0FcU8o8Gvwmfx3fty+D
/HUQPe/efh8cu9K9TsgKe/m5/wFgufc+8OSwf3h63L9QuGxd/DU9bLdHOGq3g7v9QdxRZLs/
0zUFv/t4+Aktu00bg4saW95W2DWWQf039NAafWvWzTKiCxAX6Mm8nJYBNyq+RnfP0CmcB4xF
IrBaixVxE1TeDR7hY/j2F1amDahEmO6wycqvl0b7hcrMHxAn1LWA4XJKm6dS3/xSzDcD+fH9
qBaJOYddMCYSkEbBKG0WecZQ1BkGqfBupVizZjjOUrygooUbiwrbo6lQpY4C7i5pRMtTJfPz
DLLXp8N+92SOlqGvM2mYjtna8rglJY/5Cv1tH9EbiWQktK6jwukohBQB3iETkTpLQJuqsfCi
/oamBV4is1EFBs3FDTo9vYgAd+XgTphRY4pOCoDuHFP0VIU2nXcgNXwwKdYgf9JCUkcleVQH
AwEUEc9U7Eaw/ijShO40v01iq2/4O0iMAdcTJ6C85AJUUcDY8Uw9WCVxD+zJlkQF0gVLRxkv
aNYYhEWNwnv/t0/n99tnc4sEYTFbPX6+9p3bJ4SoTLpkg+tPe4wUAW8AROVtAdSoDGijSLRi
Jb1K1mdHO5tKd1u0GKxUM9QDdSBNPowmBLgP4zEyj/cv0lQ6Cgq0/0WS0x0y6ch+TSp/UXaw
T+a5J1Nr9xQ2c564rDOs0AJ0Sq+hWYimDs+zxoNuyQMf+vQ6PlURQlO6W5lI/E924qxD1QiN
k8jT6d3fz5vJ6VBOm0qbwWlYG8eWkwYQFHu70LZTc6osTAVCRAAPjZ7Y3WlxTWV/E9qdSy5A
aIBafkZ7zKXTua7tn30umb6UpjncogRwS4j7KyQUa4oQc9XYquTW1cwdFtld0rqOxlFeaaqt
qLKiFFhd5VM5oneLRlrbeKqOLwMQoTPlaTvD4gPNxNlhJ2ifZ66Bfyi+QVCyZMU20Iscs2RY
WYBOxCKLOX34G0Rr+NhqTJ8RphzmKS+sPaRFk4e2+IKxL7zQRo1Wgd1/xctYiRmelCFkfntz
c2GJB9/yRJhVg+6ByMTX8VRPrNYfc/nXlFV/ZRX9hikWTjI+lK7ObkKWLgn+PuWZiznW4/06
uvpC4UUezdGVuvr6n91xPx5f3/5xaaY+MUjrakpbGrLKYzhavD5uP572qjC2N6xTfL0JWLRR
gCYMnVCqxAGqEsNpDgzZDIRXqGgukrjkhrV1wcvMfJVjCevSz5wsmyr7zPljRNOERBYQk6dx
E5WcmYWz9D/OTkQHXMUO0S7IU6Nfuaqr4J1zLPZmu8NMnba54qU0CPoopdLxDfdS53n4jRZ0
96Dl4fNlEkb5T3XTUrLUYkXqtz5erCJb8q5mcm6SdhB9nng1sm205kNEB3qyGC+NC3RanSV0
Qy2FuiijlRSKsq13ff6B0FrqCe4tQ3UPTu5HJDQnB7C+P9+LexnIFNRTjFS0PAbNY46b87Q8
nfA4Jivbnr5Nm2RQfz6dOOfKsGetQ+smFViV295LGtJMcL2pO5fm8mYiKn2wmLE9eequ9cIB
3GXrkQ+68fZjCzxjs2/fRev1snL8305Mamm9vPberCE6GJw2IlL96ph26wBKsp5Mv8v6vRw6
v6+sMEkFcdmlibRS34N6tbJ1c03TXBKPl5hUI5tKlxxlmNaPPc7IJIEtER4APEEiawhWBT4Z
+yOKiSE5+BHx2plyfS8wdsBYcYqdOT8bu36A7MqUmtGqZRG5v5uZWXWkhbUT2s1ZgaHdSNgs
ysm1lY1E04cXrEprR7NqYa9A/K0UZTJ8QmF1UjSRKW28+17mPCuqFWeLplipahp0n5CqLiIW
iL9VeI+F2ugzI1Zo8g392R0z9yAOMabMSsCXyD7FkCliGehORmtARrMf7DFfAPNCY75cBzDj
64sgZhjEhFsL9WB8E3zPzWUQE+zBzVUQMwpigr2+uQlibgOY26vQM7fBGb29Co3ndhR6z/iL
Mx7QE3B1NOPAA5fD4PsB5Uw1k5EQdPuX9iLrwEOa+ooGB/p+TYNvaPAXGnwb6HegK5eBvlw6
nVnkYtyUBKy2YZhNGw5tM41GB454YteN6uFZxWszI02PKXNWCbKtTSmShGptxjgNLzlf+GAB
vWJZTCCy2iqZZo6N7FJVlwth1VkFBOp9J0ic2GmSEiILUhu59fhx2L3/Mq5G22cW3I5FM9IZ
AQqrbgWUi/ZZykavzUY81o0bHYTfTYz1Lbh2owyFu2lbcRODWqRulKpSRKHgrDN25Q5JHgwq
1x2o2zHPoKdoq0LzhDoiI2Zpsh7RGRQo6UmCbuqWwI/W60jRYCzAmfSrWrk/TQAzxA0Xi2lR
W9Q6L7WKZkgiOr+pnW9Iw0AhjoqNC13npQsq7lwIZn66weJxuVHqTucA7YK1osOvt/f94HF/
2A72h8Hz9uebme1VE8M0z1hhJAC0wEMfzs0SzQbQJwVlKBLF3ExB5GL8h1RBYwrok5ZmpuoT
jCTshQ2v68GesFDvF0XhUy/MDBFdC6jrEt2RzCON5x6IRwSwzY/mtdnC/ZfVkhhBl2UtFlJV
+FHGe+/R2fRyOAZN3XscU9qSQP/1qEzperguRv3jL6U0AGd1NedmRosWXulM9PoS9+P9efv6
vntUGUX56yNuAIxE++/u/XnAjsf9406h4of3B28jRGaK7W4KCFg0B42cDS+KPNlcXl1cE7th
JtC3KojwJ09hhtc3/nTkZS1vRhc0AtryMZLfCY8nYJ5RJjKF0P4bKlDyZf9kZU9uRzjx5zma
TnxY5S+tqJLEu/1nk3LlwQrqxWuiQTi9ViXrywfPH47PoaFY5RA7dkIB19TLl5qyTZL1Y3t8
999QRlfDyFLdDARp2OvQ1eVFLKb+vrOLuneTE1puaTwiYASdgCUA+n4q/HGWaUwtWATf+CsM
wNRaBfDVkFiPWIGFAFJNAPj6ckiBr3xg6sOqWXl56z+/KnSr+ljcvT1bXnD9HvRZIMCaSnjt
sayeCH9ZsjLyPwVIA6upID5oh+isG95OYikHQdg/KzBFX/ghWfmfHqH+ZMfcH8LUSYnZbbg5
uyfOfckSyYhP3rFIgjdxohVeFlY5lf4D+7MpC26maOwPAX+WqlVOTnsLP01gG6n48nbYHo9W
8b9+npy0Th0Lu8892Hjkrz40RROwub8N0czc9ah8eH3avwyyj5fv24OuKODUJuwXI+YsLihp
KC4nM+XzSGMUH3SXvMZQUpjCIM+nEN4bvgmMEeTofWaKuIZY0qDcGUI0JBPssTIknPUU1Hz0
yFaKdVn2nM6rAhJ3iuG0oDmg3oQu/v6V6Pbwji6UIF8cVV6r4+7H64PKnvj4vH38xyksom3L
WEIG42hlr+J57RKB1m0TWgMwNYOJqLDwQynN4hetzx5oblmEWhHmgrf9AUyShGcBLGbDqith
GvF6f8BI9F5lDsoBRxjZHsHKMD9NZIatIoV/LkJDVd3YT11Z0ib8BEaSTCurMlELT0TEJ5ux
fUgbGNqfvCVh5YoFbhI0BUx7CBvIFgKYIOILITIkYtKKGdaajcYE7Xrd7hzD3xETmhjzQzwF
fKtP9naaPoTqGzsbjndu6L2WWBe5CuoxS+CSRMsINVo+2f/vRyQ1cEsaTraCfJQgV2BqPOt7
BJ+e17+btZkNs4Upj9PCpxXsZuQBWZlSsGpepxMPgcnb/HYn0TcPZq/x04Ca2b0wNpuBmABi
SGKS+5SRiPV9gD4PwI3hVxykdo5RWxSsWZiJEw34JCXBU2nAmcTslAwTCcNUlswyASnnVm7M
uZwl2o5k9PnOzMyb4N2Iz7ZYlYOYbH7RpKwbJ493lNxjvjGLq+RlLGiH5jgOJBEs71RmP+oq
txB4ud2/MFehraApVmYQ+jTPKiNs7uSkAnDSCQ3px/+ODYcwDTHZsETf6tyYKQlczmLlaArM
ZibPVefVYnt43f4cPD90R56Cvh12r+//qKilp5ft8QcVGKJcyhYq7Q5506RzJyT5TFUd6A06
X4IUdzU6HI362VSeHUQLo5MIuPu5/eN999Ke2UfV4UcNP/gWW54p60laozyOfpPGlGLaB+UZ
9/XyYjgyLZClwOycKYgAaSAOMMMEi4if5AlNcsYJVJceln2HnGekrvaDDjaqeHDIXGsRqYGg
sy0VLKgCtlGgKe9Mn8Ye2JtL9XR9vfj3kqJqsxB6Hda31J5clG5f9iAWxdvvHz9+OMKVuvsB
/oGx+AEHcUVS5FhDIJBOXbvjquAOVVLCEDYixWoky6J82WZ0UyeCNhNgjwbJ/vGfjze9gOYP
rz/slc4yGDbMb067iVr4ZsmSGmbNRuIuyesKwM50IWLBeUHKkmjy6Wds8NvxbfeqMlj93+Dl
43377xb+2L4//vnnn0bNltUKFjhwY3On9+9U6wIYLNZXANWOx0T2tJ47L3lX6qGegZQ6yU05
lcBoNSiq6Y8cp0yJ8iFPjrLOcC7UYYmMSqlBxmkksc4x/E/mZl1tBbdB3VlAiJemKd7GqHbm
fK3KnTmta8bZpiFykAvAVvnagSrWOHWALUM208W34KngCeVcpPB1bZaMUCB0DsV67w64REFS
JdR0x+UImAooYiqdiZ7nReq0oBSxyFIMdecLY5RTkcU4nGbCs2hul55W1H1ZOmeCtWuk80ZV
qML7FOo6qL0cs74Dlk36/yGfiOrqi95yRkzAARMuMLOC7hwBNQCCQnHvS4Fcc4ij2HcKxnVj
pL9/CLBxiHo8AgBCAOYsy7oAAA==

--FCuugMFkClbJLl1L--
