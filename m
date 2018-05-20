Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbeETCOS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 22:14:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:13481 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752188AbeETCOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 22:14:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,421,1520924400";
   d="gz'50?scan'50,208,50";a="57396612"
Date: Sun, 20 May 2018 10:13:51 +0800
From: kbuild test robot <lkp@intel.com>
To: Andrea Greco <andrea.greco.gapmilano@gmail.com>
Cc: kbuild-all@01.org, tobin@apporbit.com,
        andrea.greco.gapmilano@gmail.com, Andrea Greco <a.greco@4sigma.it>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] arcnet: com20020: Add com20020 io mapped version
Message-ID: <201805200952.YM4zqOi7%fengguang.wu@intel.com>
References: <20180517130529.2684-1-andrea.greco.gapmilano@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20180517130529.2684-1-andrea.greco.gapmilano@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrea,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on net-next/master]
[also build test ERROR on v4.17-rc5 next-20180517]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrea-Greco/arcnet-com20020-Add-com20020-io-mapped-version/20180520-083936
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   In file included from drivers/net/arcnet/com90xx.c:40:0:
   drivers/net/arcnet/com90xx.c: In function 'com90xx_probe':
   drivers/net/arcnet/arcdevice.h:376:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     ioread8((void __iomem *)(addr) + BUS_ALIGN * offset)
             ^
   drivers/net/arcnet/com90xx.c:161:7: note: in expansion of macro 'arcnet_inb'
      if (arcnet_inb(ioaddr, COM9026_REG_R_STATUS) == 0xFF) {
          ^~~~~~~~~~
   drivers/net/arcnet/arcdevice.h:376:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     ioread8((void __iomem *)(addr) + BUS_ALIGN * offset)
             ^
   drivers/net/arcnet/com90xx.c:171:3: note: in expansion of macro 'arcnet_inb'
      arcnet_inb(ioaddr, COM9026_REG_R_RESET);
      ^~~~~~~~~~
>> drivers/net/arcnet/com90xx.c:233:7: error: implicit declaration of function 'arcnet_readb'; did you mean 'arcnet_outsb'? [-Werror=implicit-function-declaration]
      if (arcnet_readb(base, COM9026_REG_R_STATUS) != TESTvalue) {
          ^~~~~~~~~~~~
          arcnet_outsb
>> drivers/net/arcnet/com90xx.c:247:3: error: implicit declaration of function 'arcnet_writeb'; did you mean 'arcnet_outsb'? [-Werror=implicit-function-declaration]
      arcnet_writeb(0x42, base, COM9026_REG_W_INTMASK);
      ^~~~~~~~~~~~~
      arcnet_outsb
   In file included from drivers/net/arcnet/com90xx.c:40:0:
   drivers/net/arcnet/arcdevice.h:376:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     ioread8((void __iomem *)(addr) + BUS_ALIGN * offset)
             ^
   drivers/net/arcnet/com90xx.c:312:12: note: in expansion of macro 'arcnet_inb'
      status = arcnet_inb(ioaddr, COM9026_REG_R_STATUS);
               ^~~~~~~~~~
   drivers/net/arcnet/arcdevice.h:379:18: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     iowrite8(value, (void __iomem *)addr + BUS_ALIGN * offset)
                     ^
   drivers/net/arcnet/com90xx.c:324:3: note: in expansion of macro 'arcnet_outb'
      arcnet_outb(CFLAGScmd | RESETclear | CONFIGclear,
      ^~~~~~~~~~~
   drivers/net/arcnet/arcdevice.h:376:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     ioread8((void __iomem *)(addr) + BUS_ALIGN * offset)
             ^
   drivers/net/arcnet/com90xx.c:326:12: note: in expansion of macro 'arcnet_inb'
      status = arcnet_inb(ioaddr, COM9026_REG_R_STATUS);
               ^~~~~~~~~~
   drivers/net/arcnet/arcdevice.h:379:18: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     iowrite8(value, (void __iomem *)addr + BUS_ALIGN * offset)
                     ^
   drivers/net/arcnet/com90xx.c:346:4: note: in expansion of macro 'arcnet_outb'
       arcnet_outb(NORXflag, ioaddr, COM9026_REG_W_INTMASK);
       ^~~~~~~~~~~
   drivers/net/arcnet/arcdevice.h:379:18: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     iowrite8(value, (void __iomem *)addr + BUS_ALIGN * offset)
                     ^
   drivers/net/arcnet/com90xx.c:348:4: note: in expansion of macro 'arcnet_outb'
       arcnet_outb(0, ioaddr, COM9026_REG_W_INTMASK);
       ^~~~~~~~~~~
   drivers/net/arcnet/arcdevice.h:376:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     ioread8((void __iomem *)(addr) + BUS_ALIGN * offset)
             ^
   drivers/net/arcnet/com90xx.c:383:3: note: in expansion of macro 'arcnet_inb'
      arcnet_inb(ioaddr, COM9026_REG_R_RESET);
      ^~~~~~~~~~
   drivers/net/arcnet/com90xx.c: In function 'com90xx_command':
   drivers/net/arcnet/arcdevice.h:379:18: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     iowrite8(value, (void __iomem *)addr + BUS_ALIGN * offset)
                     ^
   drivers/net/arcnet/com90xx.c:565:2: note: in expansion of macro 'arcnet_outb'
     arcnet_outb(cmd, ioaddr, COM9026_REG_W_COMMAND);
     ^~~~~~~~~~~
   drivers/net/arcnet/com90xx.c: In function 'com90xx_status':
   drivers/net/arcnet/arcdevice.h:376:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     ioread8((void __iomem *)(addr) + BUS_ALIGN * offset)
             ^
   drivers/net/arcnet/com90xx.c:572:9: note: in expansion of macro 'arcnet_inb'
     return arcnet_inb(ioaddr, COM9026_REG_R_STATUS);
            ^~~~~~~~~~
   drivers/net/arcnet/com90xx.c: In function 'com90xx_setmask':
   drivers/net/arcnet/arcdevice.h:379:18: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     iowrite8(value, (void __iomem *)addr + BUS_ALIGN * offset)
                     ^
   drivers/net/arcnet/com90xx.c:579:2: note: in expansion of macro 'arcnet_outb'
     arcnet_outb(mask, ioaddr, COM9026_REG_W_INTMASK);
     ^~~~~~~~~~~
   drivers/net/arcnet/com90xx.c: In function 'com90xx_reset':
   drivers/net/arcnet/arcdevice.h:376:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     ioread8((void __iomem *)(addr) + BUS_ALIGN * offset)
             ^
   drivers/net/arcnet/arcdevice.h:88:28: note: in expansion of macro 'arcnet_inb'
       netdev_warn(dev, fmt, ##__VA_ARGS__);  \
                               ^~~~~~~~~~~
   drivers/net/arcnet/com90xx.c:594:2: note: in expansion of macro 'arc_printk'
     arc_printk(D_INIT, dev, "Resetting (status=%02Xh)\n",
     ^~~~~~~~~~
   drivers/net/arcnet/arcdevice.h:376:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     ioread8((void __iomem *)(addr) + BUS_ALIGN * offset)
             ^
   drivers/net/arcnet/arcdevice.h:90:28: note: in expansion of macro 'arcnet_inb'
       netdev_info(dev, fmt, ##__VA_ARGS__);  \
                               ^~~~~~~~~~~
   drivers/net/arcnet/com90xx.c:594:2: note: in expansion of macro 'arc_printk'
     arc_printk(D_INIT, dev, "Resetting (status=%02Xh)\n",
     ^~~~~~~~~~
   drivers/net/arcnet/arcdevice.h:376:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     ioread8((void __iomem *)(addr) + BUS_ALIGN * offset)
             ^
   include/linux/dynamic_debug.h:144:12: note: in expansion of macro 'arcnet_inb'
             ##__VA_ARGS__);  \
               ^~~~~~~~~~~
   include/linux/netdevice.h:4419:2: note: in expansion of macro 'dynamic_netdev_dbg'
     dynamic_netdev_dbg(__dev, format, ##args);  \
     ^~~~~~~~~~~~~~~~~~
   drivers/net/arcnet/arcdevice.h:92:4: note: in expansion of macro 'netdev_dbg'
       netdev_dbg(dev, fmt, ##__VA_ARGS__);  \
       ^~~~~~~~~~
   drivers/net/arcnet/com90xx.c:594:2: note: in expansion of macro 'arc_printk'
     arc_printk(D_INIT, dev, "Resetting (status=%02Xh)\n",
     ^~~~~~~~~~
   drivers/net/arcnet/arcdevice.h:376:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     ioread8((void __iomem *)(addr) + BUS_ALIGN * offset)
             ^
   drivers/net/arcnet/com90xx.c:599:3: note: in expansion of macro 'arcnet_inb'
      arcnet_inb(ioaddr, COM9026_REG_R_RESET);
--
   drivers/net/arcnet/arc-rimi.c: In function 'check_mirror':
>> drivers/net/arcnet/arc-rimi.c:109:7: error: implicit declaration of function 'arcnet_readb'; did you mean 'arcnet_outsb'? [-Werror=implicit-function-declaration]
      if (arcnet_readb(p, COM9026_REG_R_STATUS) == TESTvalue)
          ^~~~~~~~~~~~
          arcnet_outsb
   drivers/net/arcnet/arc-rimi.c: In function 'arcrimi_found':
>> drivers/net/arcnet/arc-rimi.c:147:2: error: implicit declaration of function 'arcnet_writeb'; did you mean 'arcnet_outsb'? [-Werror=implicit-function-declaration]
     arcnet_writeb(TESTvalue, p, COM9026_REG_W_INTMASK);
     ^~~~~~~~~~~~~
     arcnet_outsb
   cc1: some warnings being treated as errors

vim +233 drivers/net/arcnet/com90xx.c

^1da177e4 Linus Torvalds 2005-04-16   95  
^1da177e4 Linus Torvalds 2005-04-16   96  static void __init com90xx_probe(void)
^1da177e4 Linus Torvalds 2005-04-16   97  {
^1da177e4 Linus Torvalds 2005-04-16   98  	int count, status, ioaddr, numprint, airq, openparen = 0;
^1da177e4 Linus Torvalds 2005-04-16   99  	unsigned long airqmask;
7f5e760c1 Joe Perches    2015-05-05  100  	int ports[(0x3f0 - 0x200) / 16 + 1] = {	0 };
d0f6ecad3 Al Viro        2005-12-02  101  	unsigned long *shmems;
d0f6ecad3 Al Viro        2005-12-02  102  	void __iomem **iomem;
^1da177e4 Linus Torvalds 2005-04-16  103  	int numports, numshmems, *port;
^1da177e4 Linus Torvalds 2005-04-16  104  	u_long *p;
d0f6ecad3 Al Viro        2005-12-02  105  	int index;
^1da177e4 Linus Torvalds 2005-04-16  106  
^1da177e4 Linus Torvalds 2005-04-16  107  	if (!io && !irq && !shmem && !*device && com90xx_skip_probe)
^1da177e4 Linus Torvalds 2005-04-16  108  		return;
^1da177e4 Linus Torvalds 2005-04-16  109  
15901dc93 Andrew Morton  2006-04-01  110  	shmems = kzalloc(((0x100000 - 0xa0000) / 0x800) * sizeof(unsigned long),
d0f6ecad3 Al Viro        2005-12-02  111  			 GFP_KERNEL);
d0f6ecad3 Al Viro        2005-12-02  112  	if (!shmems)
d0f6ecad3 Al Viro        2005-12-02  113  		return;
15901dc93 Andrew Morton  2006-04-01  114  	iomem = kzalloc(((0x100000 - 0xa0000) / 0x800) * sizeof(void __iomem *),
d0f6ecad3 Al Viro        2005-12-02  115  			GFP_KERNEL);
d0f6ecad3 Al Viro        2005-12-02  116  	if (!iomem) {
d0f6ecad3 Al Viro        2005-12-02  117  		kfree(shmems);
d0f6ecad3 Al Viro        2005-12-02  118  		return;
d0f6ecad3 Al Viro        2005-12-02  119  	}
d0f6ecad3 Al Viro        2005-12-02  120  
72aeea484 Joe Perches    2015-05-05  121  	if (BUGLVL(D_NORMAL))
05a24b234 Joe Perches    2015-05-05  122  		pr_info("%s\n", "COM90xx chipset support");
^1da177e4 Linus Torvalds 2005-04-16  123  
^1da177e4 Linus Torvalds 2005-04-16  124  	/* set up the arrays where we'll store the possible probe addresses */
^1da177e4 Linus Torvalds 2005-04-16  125  	numports = numshmems = 0;
^1da177e4 Linus Torvalds 2005-04-16  126  	if (io)
^1da177e4 Linus Torvalds 2005-04-16  127  		ports[numports++] = io;
^1da177e4 Linus Torvalds 2005-04-16  128  	else
^1da177e4 Linus Torvalds 2005-04-16  129  		for (count = 0x200; count <= 0x3f0; count += 16)
^1da177e4 Linus Torvalds 2005-04-16  130  			ports[numports++] = count;
^1da177e4 Linus Torvalds 2005-04-16  131  	if (shmem)
^1da177e4 Linus Torvalds 2005-04-16  132  		shmems[numshmems++] = shmem;
^1da177e4 Linus Torvalds 2005-04-16  133  	else
^1da177e4 Linus Torvalds 2005-04-16  134  		for (count = 0xA0000; count <= 0xFF800; count += 2048)
^1da177e4 Linus Torvalds 2005-04-16  135  			shmems[numshmems++] = count;
^1da177e4 Linus Torvalds 2005-04-16  136  
^1da177e4 Linus Torvalds 2005-04-16  137  	/* Stage 1: abandon any reserved ports, or ones with status==0xFF
^1da177e4 Linus Torvalds 2005-04-16  138  	 * (empty), and reset any others by reading the reset port.
^1da177e4 Linus Torvalds 2005-04-16  139  	 */
^1da177e4 Linus Torvalds 2005-04-16  140  	numprint = -1;
^1da177e4 Linus Torvalds 2005-04-16  141  	for (port = &ports[0]; port - ports < numports; port++) {
^1da177e4 Linus Torvalds 2005-04-16  142  		numprint++;
^1da177e4 Linus Torvalds 2005-04-16  143  		numprint %= 8;
^1da177e4 Linus Torvalds 2005-04-16  144  		if (!numprint) {
a34c0932c Joe Perches    2015-05-05  145  			arc_cont(D_INIT, "\n");
a34c0932c Joe Perches    2015-05-05  146  			arc_cont(D_INIT, "S1: ");
^1da177e4 Linus Torvalds 2005-04-16  147  		}
a34c0932c Joe Perches    2015-05-05  148  		arc_cont(D_INIT, "%Xh ", *port);
^1da177e4 Linus Torvalds 2005-04-16  149  
^1da177e4 Linus Torvalds 2005-04-16  150  		ioaddr = *port;
^1da177e4 Linus Torvalds 2005-04-16  151  
d6d7d3ed5 Joe Perches    2015-05-05  152  		if (!request_region(*port, ARCNET_TOTAL_SIZE,
d6d7d3ed5 Joe Perches    2015-05-05  153  				    "arcnet (90xx)")) {
a34c0932c Joe Perches    2015-05-05  154  			arc_cont(D_INIT_REASONS, "(request_region)\n");
a34c0932c Joe Perches    2015-05-05  155  			arc_cont(D_INIT_REASONS, "S1: ");
72aeea484 Joe Perches    2015-05-05  156  			if (BUGLVL(D_INIT_REASONS))
72aeea484 Joe Perches    2015-05-05  157  				numprint = 0;
^1da177e4 Linus Torvalds 2005-04-16  158  			*port-- = ports[--numports];
^1da177e4 Linus Torvalds 2005-04-16  159  			continue;
^1da177e4 Linus Torvalds 2005-04-16  160  		}
09dfbcd5d Joe Perches    2015-05-05 @161  		if (arcnet_inb(ioaddr, COM9026_REG_R_STATUS) == 0xFF) {
a34c0932c Joe Perches    2015-05-05  162  			arc_cont(D_INIT_REASONS, "(empty)\n");
a34c0932c Joe Perches    2015-05-05  163  			arc_cont(D_INIT_REASONS, "S1: ");
72aeea484 Joe Perches    2015-05-05  164  			if (BUGLVL(D_INIT_REASONS))
72aeea484 Joe Perches    2015-05-05  165  				numprint = 0;
^1da177e4 Linus Torvalds 2005-04-16  166  			release_region(*port, ARCNET_TOTAL_SIZE);
^1da177e4 Linus Torvalds 2005-04-16  167  			*port-- = ports[--numports];
^1da177e4 Linus Torvalds 2005-04-16  168  			continue;
^1da177e4 Linus Torvalds 2005-04-16  169  		}
09dfbcd5d Joe Perches    2015-05-05  170  		/* begin resetting card */
09dfbcd5d Joe Perches    2015-05-05 @171  		arcnet_inb(ioaddr, COM9026_REG_R_RESET);
^1da177e4 Linus Torvalds 2005-04-16  172  
a34c0932c Joe Perches    2015-05-05  173  		arc_cont(D_INIT_REASONS, "\n");
a34c0932c Joe Perches    2015-05-05  174  		arc_cont(D_INIT_REASONS, "S1: ");
72aeea484 Joe Perches    2015-05-05  175  		if (BUGLVL(D_INIT_REASONS))
72aeea484 Joe Perches    2015-05-05  176  			numprint = 0;
^1da177e4 Linus Torvalds 2005-04-16  177  	}
a34c0932c Joe Perches    2015-05-05  178  	arc_cont(D_INIT, "\n");
^1da177e4 Linus Torvalds 2005-04-16  179  
^1da177e4 Linus Torvalds 2005-04-16  180  	if (!numports) {
a34c0932c Joe Perches    2015-05-05  181  		arc_cont(D_NORMAL, "S1: No ARCnet cards found.\n");
d0f6ecad3 Al Viro        2005-12-02  182  		kfree(shmems);
d0f6ecad3 Al Viro        2005-12-02  183  		kfree(iomem);
^1da177e4 Linus Torvalds 2005-04-16  184  		return;
^1da177e4 Linus Torvalds 2005-04-16  185  	}
^1da177e4 Linus Torvalds 2005-04-16  186  	/* Stage 2: we have now reset any possible ARCnet cards, so we can't
^1da177e4 Linus Torvalds 2005-04-16  187  	 * do anything until they finish.  If D_INIT, print the list of
^1da177e4 Linus Torvalds 2005-04-16  188  	 * cards that are left.
^1da177e4 Linus Torvalds 2005-04-16  189  	 */
^1da177e4 Linus Torvalds 2005-04-16  190  	numprint = -1;
^1da177e4 Linus Torvalds 2005-04-16  191  	for (port = &ports[0]; port < ports + numports; port++) {
^1da177e4 Linus Torvalds 2005-04-16  192  		numprint++;
^1da177e4 Linus Torvalds 2005-04-16  193  		numprint %= 8;
^1da177e4 Linus Torvalds 2005-04-16  194  		if (!numprint) {
a34c0932c Joe Perches    2015-05-05  195  			arc_cont(D_INIT, "\n");
a34c0932c Joe Perches    2015-05-05  196  			arc_cont(D_INIT, "S2: ");
^1da177e4 Linus Torvalds 2005-04-16  197  		}
a34c0932c Joe Perches    2015-05-05  198  		arc_cont(D_INIT, "%Xh ", *port);
^1da177e4 Linus Torvalds 2005-04-16  199  	}
a34c0932c Joe Perches    2015-05-05  200  	arc_cont(D_INIT, "\n");
^1da177e4 Linus Torvalds 2005-04-16  201  	mdelay(RESETtime);
^1da177e4 Linus Torvalds 2005-04-16  202  
^1da177e4 Linus Torvalds 2005-04-16  203  	/* Stage 3: abandon any shmem addresses that don't have the signature
^1da177e4 Linus Torvalds 2005-04-16  204  	 * 0xD1 byte in the right place, or are read-only.
^1da177e4 Linus Torvalds 2005-04-16  205  	 */
^1da177e4 Linus Torvalds 2005-04-16  206  	numprint = -1;
d0f6ecad3 Al Viro        2005-12-02  207  	for (index = 0, p = &shmems[0]; index < numshmems; p++, index++) {
d0f6ecad3 Al Viro        2005-12-02  208  		void __iomem *base;
^1da177e4 Linus Torvalds 2005-04-16  209  
^1da177e4 Linus Torvalds 2005-04-16  210  		numprint++;
^1da177e4 Linus Torvalds 2005-04-16  211  		numprint %= 8;
^1da177e4 Linus Torvalds 2005-04-16  212  		if (!numprint) {
a34c0932c Joe Perches    2015-05-05  213  			arc_cont(D_INIT, "\n");
a34c0932c Joe Perches    2015-05-05  214  			arc_cont(D_INIT, "S3: ");
^1da177e4 Linus Torvalds 2005-04-16  215  		}
a34c0932c Joe Perches    2015-05-05  216  		arc_cont(D_INIT, "%lXh ", *p);
^1da177e4 Linus Torvalds 2005-04-16  217  
d0f6ecad3 Al Viro        2005-12-02  218  		if (!request_mem_region(*p, MIRROR_SIZE, "arcnet (90xx)")) {
a34c0932c Joe Perches    2015-05-05  219  			arc_cont(D_INIT_REASONS, "(request_mem_region)\n");
a34c0932c Joe Perches    2015-05-05  220  			arc_cont(D_INIT_REASONS, "Stage 3: ");
72aeea484 Joe Perches    2015-05-05  221  			if (BUGLVL(D_INIT_REASONS))
72aeea484 Joe Perches    2015-05-05  222  				numprint = 0;
d0f6ecad3 Al Viro        2005-12-02  223  			goto out;
d0f6ecad3 Al Viro        2005-12-02  224  		}
d0f6ecad3 Al Viro        2005-12-02  225  		base = ioremap(*p, MIRROR_SIZE);
d0f6ecad3 Al Viro        2005-12-02  226  		if (!base) {
a34c0932c Joe Perches    2015-05-05  227  			arc_cont(D_INIT_REASONS, "(ioremap)\n");
a34c0932c Joe Perches    2015-05-05  228  			arc_cont(D_INIT_REASONS, "Stage 3: ");
72aeea484 Joe Perches    2015-05-05  229  			if (BUGLVL(D_INIT_REASONS))
72aeea484 Joe Perches    2015-05-05  230  				numprint = 0;
d0f6ecad3 Al Viro        2005-12-02  231  			goto out1;
^1da177e4 Linus Torvalds 2005-04-16  232  		}
a11a5442d Joe Perches    2015-05-05 @233  		if (arcnet_readb(base, COM9026_REG_R_STATUS) != TESTvalue) {
a34c0932c Joe Perches    2015-05-05  234  			arc_cont(D_INIT_REASONS, "(%02Xh != %02Xh)\n",
a11a5442d Joe Perches    2015-05-05  235  				 arcnet_readb(base, COM9026_REG_R_STATUS),
a11a5442d Joe Perches    2015-05-05  236  				 TESTvalue);
a34c0932c Joe Perches    2015-05-05  237  			arc_cont(D_INIT_REASONS, "S3: ");
72aeea484 Joe Perches    2015-05-05  238  			if (BUGLVL(D_INIT_REASONS))
72aeea484 Joe Perches    2015-05-05  239  				numprint = 0;
d0f6ecad3 Al Viro        2005-12-02  240  			goto out2;
^1da177e4 Linus Torvalds 2005-04-16  241  		}
^1da177e4 Linus Torvalds 2005-04-16  242  		/* By writing 0x42 to the TESTvalue location, we also make
^1da177e4 Linus Torvalds 2005-04-16  243  		 * sure no "mirror" shmem areas show up - if they occur
^1da177e4 Linus Torvalds 2005-04-16  244  		 * in another pass through this loop, they will be discarded
^1da177e4 Linus Torvalds 2005-04-16  245  		 * because *cptr != TESTvalue.
^1da177e4 Linus Torvalds 2005-04-16  246  		 */
a11a5442d Joe Perches    2015-05-05 @247  		arcnet_writeb(0x42, base, COM9026_REG_W_INTMASK);
a11a5442d Joe Perches    2015-05-05  248  		if (arcnet_readb(base, COM9026_REG_R_STATUS) != 0x42) {
a34c0932c Joe Perches    2015-05-05  249  			arc_cont(D_INIT_REASONS, "(read only)\n");
a34c0932c Joe Perches    2015-05-05  250  			arc_cont(D_INIT_REASONS, "S3: ");
d0f6ecad3 Al Viro        2005-12-02  251  			goto out2;
^1da177e4 Linus Torvalds 2005-04-16  252  		}
a34c0932c Joe Perches    2015-05-05  253  		arc_cont(D_INIT_REASONS, "\n");
a34c0932c Joe Perches    2015-05-05  254  		arc_cont(D_INIT_REASONS, "S3: ");
72aeea484 Joe Perches    2015-05-05  255  		if (BUGLVL(D_INIT_REASONS))
72aeea484 Joe Perches    2015-05-05  256  			numprint = 0;
d0f6ecad3 Al Viro        2005-12-02  257  		iomem[index] = base;
d0f6ecad3 Al Viro        2005-12-02  258  		continue;
d0f6ecad3 Al Viro        2005-12-02  259  	out2:
d0f6ecad3 Al Viro        2005-12-02  260  		iounmap(base);
d0f6ecad3 Al Viro        2005-12-02  261  	out1:
d0f6ecad3 Al Viro        2005-12-02  262  		release_mem_region(*p, MIRROR_SIZE);
d0f6ecad3 Al Viro        2005-12-02  263  	out:
d0f6ecad3 Al Viro        2005-12-02  264  		*p-- = shmems[--numshmems];
d0f6ecad3 Al Viro        2005-12-02  265  		index--;
^1da177e4 Linus Torvalds 2005-04-16  266  	}
a34c0932c Joe Perches    2015-05-05  267  	arc_cont(D_INIT, "\n");
^1da177e4 Linus Torvalds 2005-04-16  268  
^1da177e4 Linus Torvalds 2005-04-16  269  	if (!numshmems) {
a34c0932c Joe Perches    2015-05-05  270  		arc_cont(D_NORMAL, "S3: No ARCnet cards found.\n");
^1da177e4 Linus Torvalds 2005-04-16  271  		for (port = &ports[0]; port < ports + numports; port++)
^1da177e4 Linus Torvalds 2005-04-16  272  			release_region(*port, ARCNET_TOTAL_SIZE);
d0f6ecad3 Al Viro        2005-12-02  273  		kfree(shmems);
d0f6ecad3 Al Viro        2005-12-02  274  		kfree(iomem);
^1da177e4 Linus Torvalds 2005-04-16  275  		return;
^1da177e4 Linus Torvalds 2005-04-16  276  	}
^1da177e4 Linus Torvalds 2005-04-16  277  	/* Stage 4: something of a dummy, to report the shmems that are
^1da177e4 Linus Torvalds 2005-04-16  278  	 * still possible after stage 3.
^1da177e4 Linus Torvalds 2005-04-16  279  	 */
^1da177e4 Linus Torvalds 2005-04-16  280  	numprint = -1;
^1da177e4 Linus Torvalds 2005-04-16  281  	for (p = &shmems[0]; p < shmems + numshmems; p++) {
^1da177e4 Linus Torvalds 2005-04-16  282  		numprint++;
^1da177e4 Linus Torvalds 2005-04-16  283  		numprint %= 8;
^1da177e4 Linus Torvalds 2005-04-16  284  		if (!numprint) {
a34c0932c Joe Perches    2015-05-05  285  			arc_cont(D_INIT, "\n");
a34c0932c Joe Perches    2015-05-05  286  			arc_cont(D_INIT, "S4: ");
^1da177e4 Linus Torvalds 2005-04-16  287  		}
a34c0932c Joe Perches    2015-05-05  288  		arc_cont(D_INIT, "%lXh ", *p);
^1da177e4 Linus Torvalds 2005-04-16  289  	}
a34c0932c Joe Perches    2015-05-05  290  	arc_cont(D_INIT, "\n");
^1da177e4 Linus Torvalds 2005-04-16  291  
^1da177e4 Linus Torvalds 2005-04-16  292  	/* Stage 5: for any ports that have the correct status, can disable
^1da177e4 Linus Torvalds 2005-04-16  293  	 * the RESET flag, and (if no irq is given) generate an autoirq,
^1da177e4 Linus Torvalds 2005-04-16  294  	 * register an ARCnet device.
^1da177e4 Linus Torvalds 2005-04-16  295  	 *
^1da177e4 Linus Torvalds 2005-04-16  296  	 * Currently, we can only register one device per probe, so quit
^1da177e4 Linus Torvalds 2005-04-16  297  	 * after the first one is found.
^1da177e4 Linus Torvalds 2005-04-16  298  	 */
^1da177e4 Linus Torvalds 2005-04-16  299  	numprint = -1;
^1da177e4 Linus Torvalds 2005-04-16  300  	for (port = &ports[0]; port < ports + numports; port++) {
^1da177e4 Linus Torvalds 2005-04-16  301  		int found = 0;
01a1d5ac4 Joe Perches    2015-05-05  302  
^1da177e4 Linus Torvalds 2005-04-16  303  		numprint++;
^1da177e4 Linus Torvalds 2005-04-16  304  		numprint %= 8;
^1da177e4 Linus Torvalds 2005-04-16  305  		if (!numprint) {
a34c0932c Joe Perches    2015-05-05  306  			arc_cont(D_INIT, "\n");
a34c0932c Joe Perches    2015-05-05  307  			arc_cont(D_INIT, "S5: ");
^1da177e4 Linus Torvalds 2005-04-16  308  		}
a34c0932c Joe Perches    2015-05-05  309  		arc_cont(D_INIT, "%Xh ", *port);
^1da177e4 Linus Torvalds 2005-04-16  310  
^1da177e4 Linus Torvalds 2005-04-16  311  		ioaddr = *port;
09dfbcd5d Joe Perches    2015-05-05  312  		status = arcnet_inb(ioaddr, COM9026_REG_R_STATUS);
^1da177e4 Linus Torvalds 2005-04-16  313  
^1da177e4 Linus Torvalds 2005-04-16  314  		if ((status & 0x9D)
^1da177e4 Linus Torvalds 2005-04-16  315  		    != (NORXflag | RECONflag | TXFREEflag | RESETflag)) {
a34c0932c Joe Perches    2015-05-05  316  			arc_cont(D_INIT_REASONS, "(status=%Xh)\n", status);
a34c0932c Joe Perches    2015-05-05  317  			arc_cont(D_INIT_REASONS, "S5: ");
72aeea484 Joe Perches    2015-05-05  318  			if (BUGLVL(D_INIT_REASONS))
72aeea484 Joe Perches    2015-05-05  319  				numprint = 0;
^1da177e4 Linus Torvalds 2005-04-16  320  			release_region(*port, ARCNET_TOTAL_SIZE);
^1da177e4 Linus Torvalds 2005-04-16  321  			*port-- = ports[--numports];
^1da177e4 Linus Torvalds 2005-04-16  322  			continue;
^1da177e4 Linus Torvalds 2005-04-16  323  		}
09dfbcd5d Joe Perches    2015-05-05  324  		arcnet_outb(CFLAGScmd | RESETclear | CONFIGclear,
09dfbcd5d Joe Perches    2015-05-05  325  			    ioaddr, COM9026_REG_W_COMMAND);
09dfbcd5d Joe Perches    2015-05-05  326  		status = arcnet_inb(ioaddr, COM9026_REG_R_STATUS);
^1da177e4 Linus Torvalds 2005-04-16  327  		if (status & RESETflag) {
a34c0932c Joe Perches    2015-05-05  328  			arc_cont(D_INIT_REASONS, " (eternal reset, status=%Xh)\n",
^1da177e4 Linus Torvalds 2005-04-16  329  				 status);
a34c0932c Joe Perches    2015-05-05  330  			arc_cont(D_INIT_REASONS, "S5: ");
72aeea484 Joe Perches    2015-05-05  331  			if (BUGLVL(D_INIT_REASONS))
72aeea484 Joe Perches    2015-05-05  332  				numprint = 0;
^1da177e4 Linus Torvalds 2005-04-16  333  			release_region(*port, ARCNET_TOTAL_SIZE);
^1da177e4 Linus Torvalds 2005-04-16  334  			*port-- = ports[--numports];
^1da177e4 Linus Torvalds 2005-04-16  335  			continue;
^1da177e4 Linus Torvalds 2005-04-16  336  		}
^1da177e4 Linus Torvalds 2005-04-16  337  		/* skip this completely if an IRQ was given, because maybe
^1da177e4 Linus Torvalds 2005-04-16  338  		 * we're on a machine that locks during autoirq!
^1da177e4 Linus Torvalds 2005-04-16  339  		 */
^1da177e4 Linus Torvalds 2005-04-16  340  		if (!irq) {
^1da177e4 Linus Torvalds 2005-04-16  341  			/* if we do this, we're sure to get an IRQ since the
^1da177e4 Linus Torvalds 2005-04-16  342  			 * card has just reset and the NORXflag is on until
^1da177e4 Linus Torvalds 2005-04-16  343  			 * we tell it to start receiving.
^1da177e4 Linus Torvalds 2005-04-16  344  			 */
^1da177e4 Linus Torvalds 2005-04-16  345  			airqmask = probe_irq_on();
09dfbcd5d Joe Perches    2015-05-05  346  			arcnet_outb(NORXflag, ioaddr, COM9026_REG_W_INTMASK);
^1da177e4 Linus Torvalds 2005-04-16  347  			udelay(1);
09dfbcd5d Joe Perches    2015-05-05  348  			arcnet_outb(0, ioaddr, COM9026_REG_W_INTMASK);
^1da177e4 Linus Torvalds 2005-04-16  349  			airq = probe_irq_off(airqmask);
^1da177e4 Linus Torvalds 2005-04-16  350  
^1da177e4 Linus Torvalds 2005-04-16  351  			if (airq <= 0) {
a34c0932c Joe Perches    2015-05-05  352  				arc_cont(D_INIT_REASONS, "(airq=%d)\n", airq);
a34c0932c Joe Perches    2015-05-05  353  				arc_cont(D_INIT_REASONS, "S5: ");
72aeea484 Joe Perches    2015-05-05  354  				if (BUGLVL(D_INIT_REASONS))
72aeea484 Joe Perches    2015-05-05  355  					numprint = 0;
^1da177e4 Linus Torvalds 2005-04-16  356  				release_region(*port, ARCNET_TOTAL_SIZE);
^1da177e4 Linus Torvalds 2005-04-16  357  				*port-- = ports[--numports];
^1da177e4 Linus Torvalds 2005-04-16  358  				continue;
^1da177e4 Linus Torvalds 2005-04-16  359  			}
^1da177e4 Linus Torvalds 2005-04-16  360  		} else {
^1da177e4 Linus Torvalds 2005-04-16  361  			airq = irq;
^1da177e4 Linus Torvalds 2005-04-16  362  		}
^1da177e4 Linus Torvalds 2005-04-16  363  
a34c0932c Joe Perches    2015-05-05  364  		arc_cont(D_INIT, "(%d,", airq);
^1da177e4 Linus Torvalds 2005-04-16  365  		openparen = 1;
^1da177e4 Linus Torvalds 2005-04-16  366  
^1da177e4 Linus Torvalds 2005-04-16  367  		/* Everything seems okay.  But which shmem, if any, puts
^1da177e4 Linus Torvalds 2005-04-16  368  		 * back its signature byte when the card is reset?
^1da177e4 Linus Torvalds 2005-04-16  369  		 *
^1da177e4 Linus Torvalds 2005-04-16  370  		 * If there are multiple cards installed, there might be
^1da177e4 Linus Torvalds 2005-04-16  371  		 * multiple shmems still in the list.
^1da177e4 Linus Torvalds 2005-04-16  372  		 */
^1da177e4 Linus Torvalds 2005-04-16  373  #ifdef FAST_PROBE
^1da177e4 Linus Torvalds 2005-04-16  374  		if (numports > 1 || numshmems > 1) {
09dfbcd5d Joe Perches    2015-05-05  375  			arcnet_inb(ioaddr, COM9026_REG_R_RESET);
^1da177e4 Linus Torvalds 2005-04-16  376  			mdelay(RESETtime);
^1da177e4 Linus Torvalds 2005-04-16  377  		} else {
^1da177e4 Linus Torvalds 2005-04-16  378  			/* just one shmem and port, assume they match */
a11a5442d Joe Perches    2015-05-05  379  			arcnet_writeb(TESTvalue, iomem[0],
a11a5442d Joe Perches    2015-05-05  380  				      COM9026_REG_W_INTMASK);
^1da177e4 Linus Torvalds 2005-04-16  381  		}
^1da177e4 Linus Torvalds 2005-04-16  382  #else
09dfbcd5d Joe Perches    2015-05-05  383  		arcnet_inb(ioaddr, COM9026_REG_R_RESET);
^1da177e4 Linus Torvalds 2005-04-16  384  		mdelay(RESETtime);
^1da177e4 Linus Torvalds 2005-04-16  385  #endif
^1da177e4 Linus Torvalds 2005-04-16  386  
d0f6ecad3 Al Viro        2005-12-02  387  		for (index = 0; index < numshmems; index++) {
d0f6ecad3 Al Viro        2005-12-02  388  			u_long ptr = shmems[index];
d0f6ecad3 Al Viro        2005-12-02  389  			void __iomem *base = iomem[index];
^1da177e4 Linus Torvalds 2005-04-16  390  
a11a5442d Joe Perches    2015-05-05  391  			if (arcnet_readb(base, COM9026_REG_R_STATUS) == TESTvalue) {	/* found one */
a34c0932c Joe Perches    2015-05-05  392  				arc_cont(D_INIT, "%lXh)\n", *p);
^1da177e4 Linus Torvalds 2005-04-16  393  				openparen = 0;
^1da177e4 Linus Torvalds 2005-04-16  394  
^1da177e4 Linus Torvalds 2005-04-16  395  				/* register the card */
d0f6ecad3 Al Viro        2005-12-02  396  				if (com90xx_found(*port, airq, ptr, base) == 0)
^1da177e4 Linus Torvalds 2005-04-16  397  					found = 1;
^1da177e4 Linus Torvalds 2005-04-16  398  				numprint = -1;
^1da177e4 Linus Torvalds 2005-04-16  399  
^1da177e4 Linus Torvalds 2005-04-16  400  				/* remove shmem from the list */
d0f6ecad3 Al Viro        2005-12-02  401  				shmems[index] = shmems[--numshmems];
d0f6ecad3 Al Viro        2005-12-02  402  				iomem[index] = iomem[numshmems];
^1da177e4 Linus Torvalds 2005-04-16  403  				break;	/* go to the next I/O port */
^1da177e4 Linus Torvalds 2005-04-16  404  			} else {
a11a5442d Joe Perches    2015-05-05  405  				arc_cont(D_INIT_REASONS, "%Xh-",
a11a5442d Joe Perches    2015-05-05  406  					 arcnet_readb(base, COM9026_REG_R_STATUS));
^1da177e4 Linus Torvalds 2005-04-16  407  			}
^1da177e4 Linus Torvalds 2005-04-16  408  		}
^1da177e4 Linus Torvalds 2005-04-16  409  
^1da177e4 Linus Torvalds 2005-04-16  410  		if (openparen) {
72aeea484 Joe Perches    2015-05-05  411  			if (BUGLVL(D_INIT))
05a24b234 Joe Perches    2015-05-05  412  				pr_cont("no matching shmem)\n");
72aeea484 Joe Perches    2015-05-05  413  			if (BUGLVL(D_INIT_REASONS)) {
05a24b234 Joe Perches    2015-05-05  414  				pr_cont("S5: ");
72aeea484 Joe Perches    2015-05-05  415  				numprint = 0;
72aeea484 Joe Perches    2015-05-05  416  			}
^1da177e4 Linus Torvalds 2005-04-16  417  		}
^1da177e4 Linus Torvalds 2005-04-16  418  		if (!found)
^1da177e4 Linus Torvalds 2005-04-16  419  			release_region(*port, ARCNET_TOTAL_SIZE);
^1da177e4 Linus Torvalds 2005-04-16  420  		*port-- = ports[--numports];
^1da177e4 Linus Torvalds 2005-04-16  421  	}
^1da177e4 Linus Torvalds 2005-04-16  422  
72aeea484 Joe Perches    2015-05-05  423  	if (BUGLVL(D_INIT_REASONS))
05a24b234 Joe Perches    2015-05-05  424  		pr_cont("\n");
^1da177e4 Linus Torvalds 2005-04-16  425  
^1da177e4 Linus Torvalds 2005-04-16  426  	/* Now put back TESTvalue on all leftover shmems. */
d0f6ecad3 Al Viro        2005-12-02  427  	for (index = 0; index < numshmems; index++) {
a11a5442d Joe Perches    2015-05-05  428  		arcnet_writeb(TESTvalue, iomem[index], COM9026_REG_W_INTMASK);
d0f6ecad3 Al Viro        2005-12-02  429  		iounmap(iomem[index]);
d0f6ecad3 Al Viro        2005-12-02  430  		release_mem_region(shmems[index], MIRROR_SIZE);
^1da177e4 Linus Torvalds 2005-04-16  431  	}
d0f6ecad3 Al Viro        2005-12-02  432  	kfree(shmems);
d0f6ecad3 Al Viro        2005-12-02  433  	kfree(iomem);
^1da177e4 Linus Torvalds 2005-04-16  434  }
^1da177e4 Linus Torvalds 2005-04-16  435  

:::::: The code at line 233 was first introduced by commit
:::::: a11a5442d108357d44d34407ce2ed9d77ab424a0 arcnet: com90xx: Use arcnet_readb/writeb routines

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--n8g4imXOkfNTN/H1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
YPUWDjzWsYdN1/8HeO+3RqvqAwA=

--n8g4imXOkfNTN/H1--
