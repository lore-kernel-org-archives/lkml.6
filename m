Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbeEQEEM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 00:04:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:5054 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750723AbeEQEEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 00:04:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,409,1520924400";
   d="gz'50?scan'50,208,50";a="47145080"
Date: Thu, 17 May 2018 12:03:47 +0800
From: kbuild test robot <lkp@intel.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: kbuild-all@01.org, netdev@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/3] net: ethernet: freescale: Allow FEC with
 COMPILE_TEST
Message-ID: <201805171124.nekhkUmB%fengguang.wu@intel.com>
References: <20180515234825.11240-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180515234825.11240-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Florian,

I love your patch! Yet something to improve:

[auto build test ERROR on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Florian-Fainelli/net-Allow-more-drivers-with-COMPILE_TEST/20180517-092807
config: m68k-allmodconfig (attached as .config)
compiler: m68k-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m68k 

All errors (new ones prefixed by >>):

   In file included from include/linux/swab.h:5:0,
                    from include/uapi/linux/byteorder/big_endian.h:13,
                    from include/linux/byteorder/big_endian.h:5,
                    from arch/m68k/include/uapi/asm/byteorder.h:5,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/m68k/include/asm/bitops.h:519,
                    from include/linux/bitops.h:38,
                    from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:9,
                    from drivers/net//ethernet/freescale/fec_main.c:24:
   drivers/net//ethernet/freescale/fec_main.c: In function 'fec_restart':
>> drivers/net//ethernet/freescale/fec_main.c:959:26: error: 'FEC_RACC' undeclared (first use in this function); did you mean 'FEC_RXIC1'?
      val = readl(fep->hwp + FEC_RACC);
                             ^
   include/uapi/linux/swab.h:117:32: note: in definition of macro '__swab32'
     (__builtin_constant_p((__u32)(x)) ? \
                                   ^
   include/linux/byteorder/generic.h:89:21: note: in expansion of macro '__le32_to_cpu'
    #define le32_to_cpu __le32_to_cpu
                        ^~~~~~~~~~~~~
   arch/m68k/include/asm/io_mm.h:452:26: note: in expansion of macro 'in_le32'
    #define readl(addr)      in_le32(addr)
                             ^~~~~~~
   drivers/net//ethernet/freescale/fec_main.c:959:9: note: in expansion of macro 'readl'
      val = readl(fep->hwp + FEC_RACC);
            ^~~~~
   drivers/net//ethernet/freescale/fec_main.c:959:26: note: each undeclared identifier is reported only once for each function it appears in
      val = readl(fep->hwp + FEC_RACC);
                             ^
   include/uapi/linux/swab.h:117:32: note: in definition of macro '__swab32'
     (__builtin_constant_p((__u32)(x)) ? \
                                   ^
   include/linux/byteorder/generic.h:89:21: note: in expansion of macro '__le32_to_cpu'
    #define le32_to_cpu __le32_to_cpu
                        ^~~~~~~~~~~~~
   arch/m68k/include/asm/io_mm.h:452:26: note: in expansion of macro 'in_le32'
    #define readl(addr)      in_le32(addr)
                             ^~~~~~~
   drivers/net//ethernet/freescale/fec_main.c:959:9: note: in expansion of macro 'readl'
      val = readl(fep->hwp + FEC_RACC);
            ^~~~~
   In file included from arch/m68k/include/asm/io_mm.h:27:0,
                    from arch/m68k/include/asm/io.h:5,
                    from include/linux/scatterlist.h:9,
                    from include/linux/dma-mapping.h:11,
                    from include/linux/skbuff.h:34,
                    from include/linux/if_ether.h:23,
                    from include/uapi/linux/ethtool.h:19,
                    from include/linux/ethtool.h:18,
                    from include/linux/netdevice.h:41,
                    from drivers/net//ethernet/freescale/fec_main.c:34:
   drivers/net//ethernet/freescale/fec_main.c:968:38: error: 'FEC_FTRL' undeclared (first use in this function); did you mean 'FEC_ECNTRL'?
      writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_FTRL);
                                         ^
   arch/m68k/include/asm/raw_io.h:48:64: note: in definition of macro 'out_le32'
    #define out_le32(addr,l) (void)((*(__force volatile __le32 *) (addr)) = cpu_to_le32(l))
                                                                   ^~~~
   drivers/net//ethernet/freescale/fec_main.c:968:3: note: in expansion of macro 'writel'
      writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_FTRL);
      ^~~~~~
   drivers/net//ethernet/freescale/fec_main.c:1034:38: error: 'FEC_R_FIFO_RSEM' undeclared (first use in this function); did you mean 'FEC_FIFO_RAM'?
      writel(FEC_ENET_RSEM_V, fep->hwp + FEC_R_FIFO_RSEM);
                                         ^
   arch/m68k/include/asm/raw_io.h:48:64: note: in definition of macro 'out_le32'
    #define out_le32(addr,l) (void)((*(__force volatile __le32 *) (addr)) = cpu_to_le32(l))
                                                                   ^~~~
   drivers/net//ethernet/freescale/fec_main.c:1034:3: note: in expansion of macro 'writel'
      writel(FEC_ENET_RSEM_V, fep->hwp + FEC_R_FIFO_RSEM);
      ^~~~~~
   drivers/net//ethernet/freescale/fec_main.c:1035:38: error: 'FEC_R_FIFO_RSFL' undeclared (first use in this function); did you mean 'FEC_R_FIFO_RSEM'?
      writel(FEC_ENET_RSFL_V, fep->hwp + FEC_R_FIFO_RSFL);
                                         ^
   arch/m68k/include/asm/raw_io.h:48:64: note: in definition of macro 'out_le32'
    #define out_le32(addr,l) (void)((*(__force volatile __le32 *) (addr)) = cpu_to_le32(l))
                                                                   ^~~~
   drivers/net//ethernet/freescale/fec_main.c:1035:3: note: in expansion of macro 'writel'
      writel(FEC_ENET_RSFL_V, fep->hwp + FEC_R_FIFO_RSFL);
      ^~~~~~
   drivers/net//ethernet/freescale/fec_main.c:1036:38: error: 'FEC_R_FIFO_RAEM' undeclared (first use in this function); did you mean 'FEC_R_FIFO_RSEM'?
      writel(FEC_ENET_RAEM_V, fep->hwp + FEC_R_FIFO_RAEM);
                                         ^
   arch/m68k/include/asm/raw_io.h:48:64: note: in definition of macro 'out_le32'
    #define out_le32(addr,l) (void)((*(__force volatile __le32 *) (addr)) = cpu_to_le32(l))
                                                                   ^~~~
   drivers/net//ethernet/freescale/fec_main.c:1036:3: note: in expansion of macro 'writel'
      writel(FEC_ENET_RAEM_V, fep->hwp + FEC_R_FIFO_RAEM);
      ^~~~~~
   drivers/net//ethernet/freescale/fec_main.c:1037:38: error: 'FEC_R_FIFO_RAFL' undeclared (first use in this function); did you mean 'FEC_R_FIFO_RSFL'?
      writel(FEC_ENET_RAFL_V, fep->hwp + FEC_R_FIFO_RAFL);
                                         ^
   arch/m68k/include/asm/raw_io.h:48:64: note: in definition of macro 'out_le32'
    #define out_le32(addr,l) (void)((*(__force volatile __le32 *) (addr)) = cpu_to_le32(l))
                                                                   ^~~~
   drivers/net//ethernet/freescale/fec_main.c:1037:3: note: in expansion of macro 'writel'
      writel(FEC_ENET_RAFL_V, fep->hwp + FEC_R_FIFO_RAFL);
      ^~~~~~
   drivers/net//ethernet/freescale/fec_main.c:1040:37: error: 'FEC_OPD' undeclared (first use in this function); did you mean 'FEC_H'?
      writel(FEC_ENET_OPD_V, fep->hwp + FEC_OPD);
                                        ^
   arch/m68k/include/asm/raw_io.h:48:64: note: in definition of macro 'out_le32'
    #define out_le32(addr,l) (void)((*(__force volatile __le32 *) (addr)) = cpu_to_le32(l))
                                                                   ^~~~
   drivers/net//ethernet/freescale/fec_main.c:1040:3: note: in expansion of macro 'writel'
      writel(FEC_ENET_OPD_V, fep->hwp + FEC_OPD);
      ^~~~~~
   drivers/net//ethernet/freescale/fec_main.c:1051:23: error: 'FEC_HASH_TABLE_HIGH' undeclared (first use in this function); did you mean 'FEC_GRP_HASH_TABLE_HIGH'?
     writel(0, fep->hwp + FEC_HASH_TABLE_HIGH);
                          ^
   arch/m68k/include/asm/raw_io.h:48:64: note: in definition of macro 'out_le32'
    #define out_le32(addr,l) (void)((*(__force volatile __le32 *) (addr)) = cpu_to_le32(l))
                                                                   ^~~~
   drivers/net//ethernet/freescale/fec_main.c:1051:2: note: in expansion of macro 'writel'

vim +959 drivers/net//ethernet/freescale/fec_main.c

14109a59c drivers/net/ethernet/freescale/fec.c      Frank Li         2013-03-26   898  
dbc64a8ea drivers/net/ethernet/freescale/fec_main.c Russell King     2014-07-08   899  /*
dbc64a8ea drivers/net/ethernet/freescale/fec_main.c Russell King     2014-07-08   900   * This function is called to start or restart the FEC during a link
dbc64a8ea drivers/net/ethernet/freescale/fec_main.c Russell King     2014-07-08   901   * change, transmit timeout, or to reconfigure the FEC.  The network
dbc64a8ea drivers/net/ethernet/freescale/fec_main.c Russell King     2014-07-08   902   * packet processing for this device must be stopped before this call.
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   903   */
^1da177e4 drivers/net/fec.c                         Linus Torvalds   2005-04-16   904  static void
ef83337d1 drivers/net/ethernet/freescale/fec_main.c Russell King     2014-07-08   905  fec_restart(struct net_device *ndev)
^1da177e4 drivers/net/fec.c                         Linus Torvalds   2005-04-16   906  {
c556167f8 drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   907  	struct fec_enet_private *fep = netdev_priv(ndev);
4c09eed9d drivers/net/ethernet/freescale/fec_main.c Jim Baxter       2013-04-19   908  	u32 val;
cd1f402c1 drivers/net/fec.c                         Uwe Kleine-König 2011-01-25   909  	u32 temp_mac[2];
cd1f402c1 drivers/net/fec.c                         Uwe Kleine-König 2011-01-25   910  	u32 rcntl = OPT_FRAME_SIZE | 0x04;
230dec613 drivers/net/ethernet/freescale/fec.c      Shawn Guo        2011-09-23   911  	u32 ecntl = 0x2; /* ETHEREN */
^1da177e4 drivers/net/fec.c                         Linus Torvalds   2005-04-16   912  
106c314c7 drivers/net/ethernet/freescale/fec_main.c Fugang Duan      2014-09-13   913  	/* Whack a reset.  We should wait for this.
106c314c7 drivers/net/ethernet/freescale/fec_main.c Fugang Duan      2014-09-13   914  	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
106c314c7 drivers/net/ethernet/freescale/fec_main.c Fugang Duan      2014-09-13   915  	 * instead of reset MAC itself.
106c314c7 drivers/net/ethernet/freescale/fec_main.c Fugang Duan      2014-09-13   916  	 */
6b7e40083 drivers/net/ethernet/freescale/fec_main.c Lothar Waßmann   2014-11-17   917  	if (fep->quirks & FEC_QUIRK_HAS_AVB) {
106c314c7 drivers/net/ethernet/freescale/fec_main.c Fugang Duan      2014-09-13   918  		writel(0, fep->hwp + FEC_ECNTRL);
106c314c7 drivers/net/ethernet/freescale/fec_main.c Fugang Duan      2014-09-13   919  	} else {
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   920  		writel(1, fep->hwp + FEC_ECNTRL);
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   921  		udelay(10);
106c314c7 drivers/net/ethernet/freescale/fec_main.c Fugang Duan      2014-09-13   922  	}
^1da177e4 drivers/net/fec.c                         Linus Torvalds   2005-04-16   923  
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   924  	/*
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   925  	 * enet-mac reset will reset mac address registers too,
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   926  	 * so need to reconfigure it.
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   927  	 */
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   928  	memcpy(&temp_mac, ndev->dev_addr, ETH_ALEN);
5cfa30397 drivers/net/ethernet/freescale/fec_main.c Johannes Berg    2016-01-24   929  	writel((__force u32)cpu_to_be32(temp_mac[0]),
5cfa30397 drivers/net/ethernet/freescale/fec_main.c Johannes Berg    2016-01-24   930  	       fep->hwp + FEC_ADDR_LOW);
5cfa30397 drivers/net/ethernet/freescale/fec_main.c Johannes Berg    2016-01-24   931  	writel((__force u32)cpu_to_be32(temp_mac[1]),
5cfa30397 drivers/net/ethernet/freescale/fec_main.c Johannes Berg    2016-01-24   932  	       fep->hwp + FEC_ADDR_HIGH);
^1da177e4 drivers/net/fec.c                         Linus Torvalds   2005-04-16   933  
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   934  	/* Clear any outstanding interrupt. */
e17f7fecd drivers/net/ethernet/freescale/fec_main.c Nimrod Andy      2014-12-11   935  	writel(0xffffffff, fep->hwp + FEC_IEVENT);
^1da177e4 drivers/net/fec.c                         Linus Torvalds   2005-04-16   936  
14109a59c drivers/net/ethernet/freescale/fec.c      Frank Li         2013-03-26   937  	fec_enet_bd_init(ndev);
14109a59c drivers/net/ethernet/freescale/fec.c      Frank Li         2013-03-26   938  
59d0f7465 drivers/net/ethernet/freescale/fec_main.c Frank Li         2014-09-13   939  	fec_enet_enable_ring(ndev);
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   940  
59d0f7465 drivers/net/ethernet/freescale/fec_main.c Frank Li         2014-09-13   941  	/* Reset tx SKB buffers. */
59d0f7465 drivers/net/ethernet/freescale/fec_main.c Frank Li         2014-09-13   942  	fec_enet_reset_skb(ndev);
^1da177e4 drivers/net/fec.c                         Linus Torvalds   2005-04-16   943  
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   944  	/* Enable MII mode */
ef83337d1 drivers/net/ethernet/freescale/fec_main.c Russell King     2014-07-08   945  	if (fep->full_duplex == DUPLEX_FULL) {
cd1f402c1 drivers/net/fec.c                         Uwe Kleine-König 2011-01-25   946  		/* FD enable */
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   947  		writel(0x04, fep->hwp + FEC_X_CNTRL);
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   948  	} else {
cd1f402c1 drivers/net/fec.c                         Uwe Kleine-König 2011-01-25   949  		/* No Rcv on Xmit */
cd1f402c1 drivers/net/fec.c                         Uwe Kleine-König 2011-01-25   950  		rcntl |= 0x02;
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   951  		writel(0x0, fep->hwp + FEC_X_CNTRL);
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   952  	}
cd1f402c1 drivers/net/fec.c                         Uwe Kleine-König 2011-01-25   953  
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   954  	/* Set MII speed */
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   955  	writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   956  
d13919301 drivers/net/ethernet/freescale/fec_main.c Guenter Roeck    2013-06-18   957  #if !defined(CONFIG_M5272)
18803495a drivers/net/ethernet/freescale/fec_main.c Greg Ungerer     2015-06-20   958  	if (fep->quirks & FEC_QUIRK_HAS_RACC) {
4c09eed9d drivers/net/ethernet/freescale/fec_main.c Jim Baxter       2013-04-19  @959  		val = readl(fep->hwp + FEC_RACC);
3ac72b7b6 drivers/net/ethernet/freescale/fec_main.c Eric Nelson      2016-09-24   960  		/* align IP header */
3ac72b7b6 drivers/net/ethernet/freescale/fec_main.c Eric Nelson      2016-09-24   961  		val |= FEC_RACC_SHIFT16;
4c09eed9d drivers/net/ethernet/freescale/fec_main.c Jim Baxter       2013-04-19   962  		if (fep->csum_flags & FLAG_RX_CSUM_ENABLED)
3ac72b7b6 drivers/net/ethernet/freescale/fec_main.c Eric Nelson      2016-09-24   963  			/* set RX checksum */
4c09eed9d drivers/net/ethernet/freescale/fec_main.c Jim Baxter       2013-04-19   964  			val |= FEC_RACC_OPTIONS;
4c09eed9d drivers/net/ethernet/freescale/fec_main.c Jim Baxter       2013-04-19   965  		else
4c09eed9d drivers/net/ethernet/freescale/fec_main.c Jim Baxter       2013-04-19   966  			val &= ~FEC_RACC_OPTIONS;
4c09eed9d drivers/net/ethernet/freescale/fec_main.c Jim Baxter       2013-04-19   967  		writel(val, fep->hwp + FEC_RACC);
55cd48c82 drivers/net/ethernet/freescale/fec_main.c Troy Kisky       2016-02-05   968  		writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_FTRL);
32867fcc0 drivers/net/ethernet/freescale/fec_main.c Fabio Estevam    2016-03-31   969  	}
d13919301 drivers/net/ethernet/freescale/fec_main.c Guenter Roeck    2013-06-18   970  #endif
4c09eed9d drivers/net/ethernet/freescale/fec_main.c Jim Baxter       2013-04-19   971  
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   972  	/*
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   973  	 * The phy interface and speed need to get configured
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   974  	 * differently on enet-mac.
^1da177e4 drivers/net/fec.c                         Linus Torvalds   2005-04-16   975  	 */
6b7e40083 drivers/net/ethernet/freescale/fec_main.c Lothar Waßmann   2014-11-17   976  	if (fep->quirks & FEC_QUIRK_ENET_MAC) {
cd1f402c1 drivers/net/fec.c                         Uwe Kleine-König 2011-01-25   977  		/* Enable flow control and length check */
cd1f402c1 drivers/net/fec.c                         Uwe Kleine-König 2011-01-25   978  		rcntl |= 0x40000000 | 0x00000020;
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   979  
230dec613 drivers/net/ethernet/freescale/fec.c      Shawn Guo        2011-09-23   980  		/* RGMII, RMII or MII */
e813bb2b9 drivers/net/ethernet/freescale/fec_main.c Markus Pargmann  2015-04-30   981  		if (fep->phy_interface == PHY_INTERFACE_MODE_RGMII ||
e813bb2b9 drivers/net/ethernet/freescale/fec_main.c Markus Pargmann  2015-04-30   982  		    fep->phy_interface == PHY_INTERFACE_MODE_RGMII_ID ||
e813bb2b9 drivers/net/ethernet/freescale/fec_main.c Markus Pargmann  2015-04-30   983  		    fep->phy_interface == PHY_INTERFACE_MODE_RGMII_RXID ||
e813bb2b9 drivers/net/ethernet/freescale/fec_main.c Markus Pargmann  2015-04-30   984  		    fep->phy_interface == PHY_INTERFACE_MODE_RGMII_TXID)
230dec613 drivers/net/ethernet/freescale/fec.c      Shawn Guo        2011-09-23   985  			rcntl |= (1 << 6);
230dec613 drivers/net/ethernet/freescale/fec.c      Shawn Guo        2011-09-23   986  		else if (fep->phy_interface == PHY_INTERFACE_MODE_RMII)
cd1f402c1 drivers/net/fec.c                         Uwe Kleine-König 2011-01-25   987  			rcntl |= (1 << 8);
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   988  		else
cd1f402c1 drivers/net/fec.c                         Uwe Kleine-König 2011-01-25   989  			rcntl &= ~(1 << 8);
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   990  
230dec613 drivers/net/ethernet/freescale/fec.c      Shawn Guo        2011-09-23   991  		/* 1G, 100M or 10M */
45f5c327c drivers/net/ethernet/freescale/fec_main.c Philippe Reynes  2016-05-10   992  		if (ndev->phydev) {
45f5c327c drivers/net/ethernet/freescale/fec_main.c Philippe Reynes  2016-05-10   993  			if (ndev->phydev->speed == SPEED_1000)
230dec613 drivers/net/ethernet/freescale/fec.c      Shawn Guo        2011-09-23   994  				ecntl |= (1 << 5);
45f5c327c drivers/net/ethernet/freescale/fec_main.c Philippe Reynes  2016-05-10   995  			else if (ndev->phydev->speed == SPEED_100)
cd1f402c1 drivers/net/fec.c                         Uwe Kleine-König 2011-01-25   996  				rcntl &= ~(1 << 9);
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19   997  			else
cd1f402c1 drivers/net/fec.c                         Uwe Kleine-König 2011-01-25   998  				rcntl |= (1 << 9);
230dec613 drivers/net/ethernet/freescale/fec.c      Shawn Guo        2011-09-23   999  		}
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19  1000  	} else {
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19  1001  #ifdef FEC_MIIGSK_ENR
6b7e40083 drivers/net/ethernet/freescale/fec_main.c Lothar Waßmann   2014-11-17  1002  		if (fep->quirks & FEC_QUIRK_USE_GASKET) {
8d82f219c drivers/net/ethernet/freescale/fec.c      Eric Benard      2012-01-12  1003  			u32 cfgr;
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19  1004  			/* disable the gasket and wait */
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19  1005  			writel(0, fep->hwp + FEC_MIIGSK_ENR);
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19  1006  			while (readl(fep->hwp + FEC_MIIGSK_ENR) & 4)
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19  1007  				udelay(1);
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19  1008  
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19  1009  			/*
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19  1010  			 * configure the gasket:
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19  1011  			 *   RMII, 50 MHz, no loopback, no echo
0ca1e290b drivers/net/fec.c                         Shawn Guo        2011-07-01  1012  			 *   MII, 25 MHz, no loopback, no echo
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19  1013  			 */
8d82f219c drivers/net/ethernet/freescale/fec.c      Eric Benard      2012-01-12  1014  			cfgr = (fep->phy_interface == PHY_INTERFACE_MODE_RMII)
8d82f219c drivers/net/ethernet/freescale/fec.c      Eric Benard      2012-01-12  1015  				? BM_MIIGSK_CFGR_RMII : BM_MIIGSK_CFGR_MII;
45f5c327c drivers/net/ethernet/freescale/fec_main.c Philippe Reynes  2016-05-10  1016  			if (ndev->phydev && ndev->phydev->speed == SPEED_10)
8d82f219c drivers/net/ethernet/freescale/fec.c      Eric Benard      2012-01-12  1017  				cfgr |= BM_MIIGSK_CFGR_FRCONT_10M;
8d82f219c drivers/net/ethernet/freescale/fec.c      Eric Benard      2012-01-12  1018  			writel(cfgr, fep->hwp + FEC_MIIGSK_CFGR);
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19  1019  
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19  1020  			/* re-enable the gasket */
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19  1021  			writel(2, fep->hwp + FEC_MIIGSK_ENR);
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19  1022  		}
45993653b drivers/net/fec.c                         Uwe Kleine-König 2011-01-19  1023  #endif
^1da177e4 drivers/net/fec.c                         Linus Torvalds   2005-04-16  1024  	}
baa70a5c4 drivers/net/ethernet/freescale/fec.c      Frank Li         2013-01-16  1025  

:::::: The code at line 959 was first introduced by commit
:::::: 4c09eed9dc422e980fabdb25434ef68e599b704c net: fec: Enable imx6 enet checksum acceleration.

:::::: TO: Jim Baxter <jim_baxter@mentor.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--huq684BweRXVnRxX
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
eOQY7yGyWv4PDdYsYNDFAgA=

--huq684BweRXVnRxX--
