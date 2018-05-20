Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752566AbeETDcf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 23:32:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:64241 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752459AbeETDce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 23:32:34 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,421,1520924400";
   d="scan'208";a="200837365"
Date: Sun, 20 May 2018 11:31:49 +0800
From: kbuild test robot <lkp@intel.com>
To: Andrea Greco <andrea.greco.gapmilano@gmail.com>
Cc: kbuild-all@01.org, tobin@apporbit.com,
        andrea.greco.gapmilano@gmail.com, Andrea Greco <a.greco@4sigma.it>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] arcnet: com20020: Add com20020 io mapped version
Message-ID: <201805201113.i0qNu9yG%fengguang.wu@intel.com>
References: <20180517130529.2684-1-andrea.greco.gapmilano@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517130529.2684-1-andrea.greco.gapmilano@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]
[also build test WARNING on v4.17-rc5 next-20180517]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrea-Greco/arcnet-com20020-Add-com20020-io-mapped-version/20180520-083936
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/net/arcnet/com90xx.c:484:13: sparse: undefined identifier 'arcnet_readb'
   drivers/net/arcnet/com90xx.c:534:28: sparse: undefined identifier 'arcnet_readb'
   drivers/net/arcnet/com90xx.c:613:13: sparse: undefined identifier 'arcnet_readb'
   drivers/net/arcnet/com90xx.c:233:21: sparse: undefined identifier 'arcnet_readb'
   drivers/net/arcnet/com90xx.c:234:25: sparse: undefined identifier 'arcnet_readb'
   drivers/net/arcnet/com90xx.c:247:17: sparse: undefined identifier 'arcnet_writeb'
   drivers/net/arcnet/com90xx.c:248:21: sparse: undefined identifier 'arcnet_readb'
   drivers/net/arcnet/com90xx.c:391:29: sparse: undefined identifier 'arcnet_readb'
   drivers/net/arcnet/com90xx.c:405:33: sparse: undefined identifier 'arcnet_readb'
   drivers/net/arcnet/com90xx.c:428:17: sparse: undefined identifier 'arcnet_writeb'
   drivers/net/arcnet/com90xx.c:446:21: sparse: undefined identifier 'arcnet_readb'
>> drivers/net/arcnet/com90xx.c:233:33: sparse: call with no type!
   drivers/net/arcnet/com90xx.c:234:25: sparse: call with no type!
   drivers/net/arcnet/com90xx.c:247:30: sparse: call with no type!
   drivers/net/arcnet/com90xx.c:248:33: sparse: call with no type!
   drivers/net/arcnet/com90xx.c:391:41: sparse: call with no type!
   drivers/net/arcnet/com90xx.c:405:33: sparse: call with no type!
   drivers/net/arcnet/com90xx.c:428:30: sparse: call with no type!
   drivers/net/arcnet/com90xx.c:446:33: sparse: call with no type!
   drivers/net/arcnet/com90xx.c:484:25: sparse: call with no type!
   drivers/net/arcnet/com90xx.c:485:25: sparse: call with no type!
   drivers/net/arcnet/com90xx.c:486:25: sparse: call with no type!
   drivers/net/arcnet/com90xx.c:534:40: sparse: call with no type!
   drivers/net/arcnet/com90xx.c:613:25: sparse: call with no type!
>> drivers/net/arcnet/com90xx.c:615:25: sparse: unknown expression (4 0)
>> drivers/net/arcnet/com90xx.c:615:25: sparse: unknown expression (4 0)
>> drivers/net/arcnet/com90xx.c:615:25: sparse: unknown expression (4 0)
>> drivers/net/arcnet/com90xx.c:615:25: sparse: unknown expression (4 0)
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
   drivers/net/arcnet/com90xx.c:233:7: error: implicit declaration of function 'arcnet_readb'; did you mean 'arcnet_outsb'? [-Werror=implicit-function-declaration]
      if (arcnet_readb(base, COM9026_REG_R_STATUS) != TESTvalue) {
          ^~~~~~~~~~~~
          arcnet_outsb
   drivers/net/arcnet/com90xx.c:247:3: error: implicit declaration of function 'arcnet_writeb'; did you mean 'arcnet_outsb'? [-Werror=implicit-function-declaration]
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
       netdev_warn(dev, fmt, ##__VA_ARGS__);  115-                            ^~~~~~~~~~~
   drivers/net/arcnet/com90xx.c:594:2: note: in expansion of macro 'arc_printk'
     arc_printk(D_INIT, dev, "Resetting (status=%02Xh)n",
     ^~~~~~~~~~
   drivers/net/arcnet/arcdevice.h:376:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     ioread8((void __iomem *)(addr) + BUS_ALIGN * offset)
             ^
   drivers/net/arcnet/arcdevice.h:90:28: note: in expansion of macro 'arcnet_inb'
       netdev_info(dev, fmt, ##__VA_ARGS__);  124-                            ^~~~~~~~~~~
   drivers/net/arcnet/com90xx.c:594:2: note: in expansion of macro 'arc_printk'
     arc_printk(D_INIT, dev, "Resetting (status=%02Xh)n",
     ^~~~~~~~~~
   drivers/net/arcnet/arcdevice.h:376:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
--
   drivers/net/arcnet/arc-rimi.c:147:9: sparse: undefined identifier 'arcnet_writeb'
   drivers/net/arcnet/arc-rimi.c:148:9: sparse: undefined identifier 'arcnet_writeb'
   drivers/net/arcnet/arc-rimi.c:158:13: sparse: undefined identifier 'arcnet_readb'
   drivers/net/arcnet/arc-rimi.c:210:28: sparse: undefined identifier 'arcnet_readb'
   drivers/net/arcnet/arc-rimi.c:284:9: sparse: undefined identifier 'arcnet_writeb'
   drivers/net/arcnet/arc-rimi.c:276:16: sparse: undefined identifier 'arcnet_readb'
   drivers/net/arcnet/arc-rimi.c:268:9: sparse: undefined identifier 'arcnet_writeb'
   drivers/net/arcnet/arc-rimi.c:245:9: sparse: undefined identifier 'arcnet_readb'
   drivers/net/arcnet/arc-rimi.c:245:9: sparse: undefined identifier 'arcnet_readb'
   drivers/net/arcnet/arc-rimi.c:245:9: sparse: undefined identifier 'arcnet_readb'
   drivers/net/arcnet/arc-rimi.c:249:17: sparse: undefined identifier 'arcnet_writeb'
   drivers/net/arcnet/arc-rimi.c:253:9: sparse: undefined identifier 'arcnet_writeb'
   drivers/net/arcnet/arc-rimi.c:254:9: sparse: undefined identifier 'arcnet_writeb'
   drivers/net/arcnet/arc-rimi.c:257:9: sparse: undefined identifier 'arcnet_writeb'
   drivers/net/arcnet/arc-rimi.c:109:21: sparse: undefined identifier 'arcnet_readb'
>> drivers/net/arcnet/arc-rimi.c:109:33: sparse: call with no type!
   drivers/net/arcnet/arc-rimi.c:147:22: sparse: call with no type!
   drivers/net/arcnet/arc-rimi.c:148:22: sparse: call with no type!
   drivers/net/arcnet/arc-rimi.c:158:25: sparse: call with no type!
   drivers/net/arcnet/arc-rimi.c:159:25: sparse: call with no type!
   drivers/net/arcnet/arc-rimi.c:160:25: sparse: call with no type!
   drivers/net/arcnet/arc-rimi.c:210:40: sparse: call with no type!
   drivers/net/arcnet/arc-rimi.c:245:9: sparse: call with no type!
   drivers/net/arcnet/arc-rimi.c:245:9: sparse: call with no type!
   drivers/net/arcnet/arc-rimi.c:245:9: sparse: call with no type!
   drivers/net/arcnet/arc-rimi.c:249:30: sparse: call with no type!
   drivers/net/arcnet/arc-rimi.c:253:22: sparse: call with no type!
   drivers/net/arcnet/arc-rimi.c:254:22: sparse: call with no type!
   drivers/net/arcnet/arc-rimi.c:257:22: sparse: call with no type!
   drivers/net/arcnet/arc-rimi.c:268:22: sparse: call with no type!
   drivers/net/arcnet/arc-rimi.c:276:28: sparse: call with no type!
   drivers/net/arcnet/arc-rimi.c:284:22: sparse: call with no type!
   drivers/net/arcnet/arc-rimi.c: In function 'check_mirror':
   drivers/net/arcnet/arc-rimi.c:109:7: error: implicit declaration of function 'arcnet_readb'; did you mean 'arcnet_outsb'? [-Werror=implicit-function-declaration]
      if (arcnet_readb(p, COM9026_REG_R_STATUS) == TESTvalue)
          ^~~~~~~~~~~~
          arcnet_outsb
   drivers/net/arcnet/arc-rimi.c: In function 'arcrimi_found':
   drivers/net/arcnet/arc-rimi.c:147:2: error: implicit declaration of function 'arcnet_writeb'; did you mean 'arcnet_outsb'? [-Werror=implicit-function-declaration]
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
09dfbcd5d Joe Perches    2015-05-05  161  		if (arcnet_inb(ioaddr, COM9026_REG_R_STATUS) == 0xFF) {
a34c0932c Joe Perches    2015-05-05  162  			arc_cont(D_INIT_REASONS, "(empty)\n");
a34c0932c Joe Perches    2015-05-05  163  			arc_cont(D_INIT_REASONS, "S1: ");
72aeea484 Joe Perches    2015-05-05  164  			if (BUGLVL(D_INIT_REASONS))
72aeea484 Joe Perches    2015-05-05  165  				numprint = 0;
^1da177e4 Linus Torvalds 2005-04-16  166  			release_region(*port, ARCNET_TOTAL_SIZE);
^1da177e4 Linus Torvalds 2005-04-16  167  			*port-- = ports[--numports];
^1da177e4 Linus Torvalds 2005-04-16  168  			continue;
^1da177e4 Linus Torvalds 2005-04-16  169  		}
09dfbcd5d Joe Perches    2015-05-05  170  		/* begin resetting card */
09dfbcd5d Joe Perches    2015-05-05  171  		arcnet_inb(ioaddr, COM9026_REG_R_RESET);
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
a11a5442d Joe Perches    2015-05-05  247  		arcnet_writeb(0x42, base, COM9026_REG_W_INTMASK);
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
a11a5442d Joe Perches    2015-05-05 @391  			if (arcnet_readb(base, COM9026_REG_R_STATUS) == TESTvalue) {	/* found one */
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
