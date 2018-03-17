Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753127AbeCQVB4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 17:01:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:44804 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751098AbeCQVBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 17:01:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,322,1517904000";
   d="scan'208";a="35887010"
Date: Sun, 18 Mar 2018 05:01:07 +0800
From: kbuild test robot <lkp@intel.com>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: kbuild-all@01.org, linus.walleij@linaro.org, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v2 4/8] gpio: pcie-idio-24: Implement
 get_multiple/set_multiple callbacks
Message-ID: <201803180455.iYYrhrXD%fengguang.wu@intel.com>
References: <41c682a781e20b2db55491d36d600d56bb6b5c66.1521128287.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41c682a781e20b2db55491d36d600d56bb6b5c66.1521128287.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

I love your patch! Perhaps something to improve:

[auto build test WARNING on v4.16-rc4]
[also build test WARNING on next-20180316]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/William-Breathitt-Gray/Implement-get_multiple-for-ACCES-and-PC-104-drivers/20180317-224135
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/gpio/gpio-pcie-idio-24.c:231:17: sparse: undefined identifier 'word_mask'
   drivers/gpio/gpio-pcie-idio-24.c:232:22: sparse: undefined identifier 'word_mask'
>> drivers/gpio/gpio-pcie-idio-24.c:331:43: sparse: incorrect type in argument 1 (different modifiers) @@    expected void [noderef] <asn:2>*<noident> @@    got unsigned char cvoid [noderef] <asn:2>*<noident> @@
   drivers/gpio/gpio-pcie-idio-24.c:333:43: sparse: incorrect type in argument 2 (different modifiers) @@    expected void [noderef] <asn:2>*<noident> @@    got unsigned char cvoid [noderef] <asn:2>*<noident> @@
>> drivers/gpio/gpio-pcie-idio-24.c:518:30: sparse: incorrect type in assignment (incompatible argument 2 (different base types)) @@    expected void ( *set )( ... ) @@    got void ( *set )( ... ) @@
>> drivers/gpio/gpio-pcie-idio-24.c:210:27: sparse: dereference of noderef expression
   drivers/gpio/gpio-pcie-idio-24.c:210:52: sparse: dereference of noderef expression
   drivers/gpio/gpio-pcie-idio-24.c:211:27: sparse: dereference of noderef expression
   drivers/gpio/gpio-pcie-idio-24.c:211:54: sparse: dereference of noderef expression
   drivers/gpio/gpio-pcie-idio-24.c:212:27: sparse: dereference of noderef expression
   drivers/gpio/gpio-pcie-idio-24.c:212:52: sparse: dereference of noderef expression
>> drivers/gpio/gpio-pcie-idio-24.c:231:17: sparse: generating address of non-lvalue (3)
   drivers/gpio/gpio-pcie-idio-24.c:306:27: sparse: dereference of noderef expression
   drivers/gpio/gpio-pcie-idio-24.c:306:52: sparse: dereference of noderef expression
   drivers/gpio/gpio-pcie-idio-24.c:307:27: sparse: dereference of noderef expression
   drivers/gpio/gpio-pcie-idio-24.c: In function 'idio_24_gpio_get_multiple':
   drivers/gpio/gpio-pcie-idio-24.c:231:3: error: 'word_mask' undeclared (first use in this function); did you mean 'port_mask'?
      word_mask = mask[word_index] & (port_mask << word_offset);
      ^~~~~~~~~
      port_mask
   drivers/gpio/gpio-pcie-idio-24.c:231:3: note: each undeclared identifier is reported only once for each function it appears in
   drivers/gpio/gpio-pcie-idio-24.c:239:25: warning: passing argument 1 of 'ioread8' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
       port_state = ioread8(ports + i);
                            ^~~~~
   In file included from arch/x86/include/asm/io.h:223:0,
                    from arch/x86/include/asm/realmode.h:15,
                    from arch/x86/include/asm/acpi.h:33,
                    from arch/x86/include/asm/fixmap.h:19,
                    from arch/x86/include/asm/apic.h:10,
                    from arch/x86/include/asm/smp.h:13,
                    from arch/x86/include/asm/mmzone_64.h:11,
                    from arch/x86/include/asm/mmzone.h:5,
                    from include/linux/mmzone.h:912,
                    from include/linux/gfp.h:6,
                    from include/linux/idr.h:16,
                    from include/linux/kernfs.h:14,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from drivers/gpio/gpio-pcie-idio-24.c:20:
   include/asm-generic/iomap.h:29:21: note: expected 'void *' but argument is of type 'const u8 * {aka const unsigned char *}'
    extern unsigned int ioread8(void __iomem *);
                        ^~~~~~~
   drivers/gpio/gpio-pcie-idio-24.c:206:16: warning: unused variable 'mask_word' [-Wunused-variable]
     unsigned long mask_word;
                   ^~~~~~~~~
   drivers/gpio/gpio-pcie-idio-24.c: In function 'idio_24_gpio_set_multiple':
   drivers/gpio/gpio-pcie-idio-24.c:302:16: error: redeclaration of 'gpio_mask' with no linkage
     unsigned long gpio_mask;
                   ^~~~~~~~~
   drivers/gpio/gpio-pcie-idio-24.c:299:16: note: previous declaration of 'gpio_mask' was here
     unsigned long gpio_mask;
                   ^~~~~~~~~
   drivers/gpio/gpio-pcie-idio-24.c:331:23: warning: passing argument 1 of 'ioread8' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      out_state = ioread8(ports + i) & ~gpio_mask;
                          ^~~~~
   In file included from arch/x86/include/asm/io.h:223:0,
                    from arch/x86/include/asm/realmode.h:15,
                    from arch/x86/include/asm/acpi.h:33,
                    from arch/x86/include/asm/fixmap.h:19,
                    from arch/x86/include/asm/apic.h:10,
                    from arch/x86/include/asm/smp.h:13,
                    from arch/x86/include/asm/mmzone_64.h:11,
                    from arch/x86/include/asm/mmzone.h:5,
                    from include/linux/mmzone.h:912,
                    from include/linux/gfp.h:6,
                    from include/linux/idr.h:16,
                    from include/linux/kernfs.h:14,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from drivers/gpio/gpio-pcie-idio-24.c:20:
   include/asm-generic/iomap.h:29:21: note: expected 'void *' but argument is of type 'const u8 * {aka const unsigned char *}'
    extern unsigned int ioread8(void __iomem *);
                        ^~~~~~~
   drivers/gpio/gpio-pcie-idio-24.c:333:23: warning: passing argument 2 of 'iowrite8' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      iowrite8(out_state, ports + i);
                          ^~~~~
   In file included from arch/x86/include/asm/io.h:223:0,
                    from arch/x86/include/asm/realmode.h:15,
                    from arch/x86/include/asm/acpi.h:33,
                    from arch/x86/include/asm/fixmap.h:19,
                    from arch/x86/include/asm/apic.h:10,
                    from arch/x86/include/asm/smp.h:13,
                    from arch/x86/include/asm/mmzone_64.h:11,
                    from arch/x86/include/asm/mmzone.h:5,
                    from include/linux/mmzone.h:912,
                    from include/linux/gfp.h:6,
                    from include/linux/idr.h:16,
                    from include/linux/kernfs.h:14,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from drivers/gpio/gpio-pcie-idio-24.c:20:
   include/asm-generic/iomap.h:39:13: note: expected 'void *' but argument is of type 'const u8 * {aka const unsigned char *}'
    extern void iowrite8(u8, void __iomem *);
                ^~~~~~~~
   drivers/gpio/gpio-pcie-idio-24.c: In function 'idio_24_probe':
   drivers/gpio/gpio-pcie-idio-24.c:518:23: error: assignment from incompatible pointer type [-Werror=incompatible-pointer-types]
     idio24gpio->chip.set = idio_24_gpio_set_multiple;
                          ^
   cc1: some warnings being treated as errors

vim +331 drivers/gpio/gpio-pcie-idio-24.c

   196	
   197	static int idio_24_gpio_get_multiple(struct gpio_chip *chip,
   198		unsigned long *mask, unsigned long *bits)
   199	{
   200		struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
   201		size_t i;
   202		const unsigned int gpio_reg_size = 8;
   203		unsigned int bits_offset;
   204		size_t word_index;
   205		unsigned int word_offset;
   206		unsigned long mask_word;
   207		const unsigned long port_mask = GENMASK(gpio_reg_size, 0);
   208		unsigned long port_state;
   209		const u8 __iomem ports[] = {
 > 210			idio24gpio->reg->out0_7, idio24gpio->reg->out8_15,
   211			idio24gpio->reg->out16_23, idio24gpio->reg->in0_7,
   212			idio24gpio->reg->in8_15, idio24gpio->reg->in16_23
   213		};
   214		const unsigned long out_mode_mask = BIT(1);
   215	
   216		/* clear bits array to a clean slate */
   217		bitmap_zero(bits, chip->ngpio);
   218	
   219		/* get bits are evaluated a gpio port register at a time */
   220		for (i = 0; i < ARRAY_SIZE(ports); i++) {
   221			/* gpio offset in bits array */
   222			bits_offset = i * gpio_reg_size;
   223	
   224			/* word index for bits array */
   225			word_index = BIT_WORD(bits_offset);
   226	
   227			/* gpio offset within current word of bits array */
   228			word_offset = bits_offset % BITS_PER_LONG;
   229	
   230			/* mask of get bits for current gpio within current word */
 > 231			word_mask = mask[word_index] & (port_mask << word_offset);
   232			if (!word_mask) {
   233				/* no get bits in this port so skip to next one */
   234				continue;
   235			}
   236	
   237			/* read bits from current gpio port (port 6 is TTL GPIO) */
   238			if (i < 6)
   239				port_state = ioread8(ports + i);
   240			else if (ioread8(&idio24gpio->reg->ctl) & out_mode_mask)
   241				port_state = ioread8(&idio24gpio->reg->ttl_out0_7);
   242			else
   243				port_state = ioread8(&idio24gpio->reg->ttl_in0_7);
   244	
   245			/* store acquired bits at respective bits array offset */
   246			bits[word_index] |= port_state << word_offset;
   247		}
   248	
   249		return 0;
   250	}
   251	
   252	static void idio_24_gpio_set(struct gpio_chip *chip, unsigned int offset,
   253		int value)
   254	{
   255		struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
   256		const unsigned long out_mode_mask = BIT(1);
   257		void __iomem *base;
   258		const unsigned int mask = BIT(offset % 8);
   259		unsigned long flags;
   260		unsigned int out_state;
   261	
   262		/* Isolated Inputs */
   263		if (offset > 23 && offset < 48)
   264			return;
   265	
   266		/* TTL/CMOS Inputs */
   267		if (offset > 47 && !(ioread8(&idio24gpio->reg->ctl) & out_mode_mask))
   268			return;
   269	
   270		/* TTL/CMOS Outputs */
   271		if (offset > 47)
   272			base = &idio24gpio->reg->ttl_out0_7;
   273		/* FET Outputs */
   274		else if (offset > 15)
   275			base = &idio24gpio->reg->out16_23;
   276		else if (offset > 7)
   277			base = &idio24gpio->reg->out8_15;
   278		else
   279			base = &idio24gpio->reg->out0_7;
   280	
   281		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
   282	
   283		if (value)
   284			out_state = ioread8(base) | mask;
   285		else
   286			out_state = ioread8(base) & ~mask;
   287	
   288		iowrite8(out_state, base);
   289	
   290		raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
   291	}
   292	
   293	static void idio_24_gpio_set_multiple(struct gpio_chip *chip,
   294		unsigned long *mask, unsigned long *bits)
   295	{
   296		struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
   297		size_t i;
   298		unsigned long bits_offset;
   299		unsigned long gpio_mask;
   300		const unsigned int gpio_reg_size = 8;
   301		const unsigned long port_mask = GENMASK(gpio_reg_size, 0);
   302		unsigned long gpio_mask;
   303		unsigned long flags;
   304		unsigned int out_state;
   305		const u8 __iomem ports[] = {
   306			idio24gpio->reg->out0_7, idio24gpio->reg->out8_15,
   307			idio24gpio->reg->out16_23
   308		};
   309		const unsigned long out_mode_mask = BIT(1);
   310		const unsigned int ttl_offset = 48;
   311		const size_t ttl_i = BIT_WORD(ttl_offset);
   312		const unsigned int word_offset = ttl_offset % BITS_PER_LONG;
   313		const unsigned long ttl_mask = (mask[ttl_i] >> word_offset) & port_mask;
   314		const unsigned long ttl_bits = (bits[ttl_i] >> word_offset) & ttl_mask;
   315	
   316		/* set bits are processed a gpio port register at a time */
   317		for (i = 0; i < ARRAY_SIZE(ports); i++) {
   318			/* gpio offset in bits array */
   319			bits_offset = i * gpio_reg_size;
   320	
   321			/* check if any set bits for current port */
   322			gpio_mask = (*mask >> bits_offset) & port_mask;
   323			if (!gpio_mask) {
   324				/* no set bits for this port so move on to next port */
   325				continue;
   326			}
   327	
   328			raw_spin_lock_irqsave(&idio24gpio->lock, flags);
   329	
   330			/* process output lines */
 > 331			out_state = ioread8(ports + i) & ~gpio_mask;
   332			out_state |= (*bits >> bits_offset) & gpio_mask;
   333			iowrite8(out_state, ports + i);
   334	
   335			raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
   336		}
   337	
   338		/* check if setting TTL lines and if they are in output mode */
   339		if (!ttl_mask || !(ioread8(&idio24gpio->reg->ctl) & out_mode_mask))
   340			return;
   341	
   342		/* handle TTL output */
   343		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
   344	
   345		/* process output lines */
   346		out_state = ioread8(&idio24gpio->reg->ttl_out0_7) & ~ttl_mask;
   347		out_state |= ttl_bits;
   348		iowrite8(out_state, &idio24gpio->reg->ttl_out0_7);
   349	
   350		raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
   351	}
   352	
   353	static void idio_24_irq_ack(struct irq_data *data)
   354	{
   355	}
   356	
   357	static void idio_24_irq_mask(struct irq_data *data)
   358	{
   359		struct gpio_chip *const chip = irq_data_get_irq_chip_data(data);
   360		struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
   361		unsigned long flags;
   362		const unsigned long bit_offset = irqd_to_hwirq(data) - 24;
   363		unsigned char new_irq_mask;
   364		const unsigned long bank_offset = bit_offset/8 * 8;
   365		unsigned char cos_enable_state;
   366	
   367		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
   368	
   369		idio24gpio->irq_mask &= BIT(bit_offset);
   370		new_irq_mask = idio24gpio->irq_mask >> bank_offset;
   371	
   372		if (!new_irq_mask) {
   373			cos_enable_state = ioread8(&idio24gpio->reg->cos_enable);
   374	
   375			/* Disable Rising Edge detection */
   376			cos_enable_state &= ~BIT(bank_offset);
   377			/* Disable Falling Edge detection */
   378			cos_enable_state &= ~BIT(bank_offset + 4);
   379	
   380			iowrite8(cos_enable_state, &idio24gpio->reg->cos_enable);
   381		}
   382	
   383		raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
   384	}
   385	
   386	static void idio_24_irq_unmask(struct irq_data *data)
   387	{
   388		struct gpio_chip *const chip = irq_data_get_irq_chip_data(data);
   389		struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
   390		unsigned long flags;
   391		unsigned char prev_irq_mask;
   392		const unsigned long bit_offset = irqd_to_hwirq(data) - 24;
   393		const unsigned long bank_offset = bit_offset/8 * 8;
   394		unsigned char cos_enable_state;
   395	
   396		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
   397	
   398		prev_irq_mask = idio24gpio->irq_mask >> bank_offset;
   399		idio24gpio->irq_mask |= BIT(bit_offset);
   400	
   401		if (!prev_irq_mask) {
   402			cos_enable_state = ioread8(&idio24gpio->reg->cos_enable);
   403	
   404			/* Enable Rising Edge detection */
   405			cos_enable_state |= BIT(bank_offset);
   406			/* Enable Falling Edge detection */
   407			cos_enable_state |= BIT(bank_offset + 4);
   408	
   409			iowrite8(cos_enable_state, &idio24gpio->reg->cos_enable);
   410		}
   411	
   412		raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
   413	}
   414	
   415	static int idio_24_irq_set_type(struct irq_data *data, unsigned int flow_type)
   416	{
   417		/* The only valid irq types are none and both-edges */
   418		if (flow_type != IRQ_TYPE_NONE &&
   419			(flow_type & IRQ_TYPE_EDGE_BOTH) != IRQ_TYPE_EDGE_BOTH)
   420			return -EINVAL;
   421	
   422		return 0;
   423	}
   424	
   425	static struct irq_chip idio_24_irqchip = {
   426		.name = "pcie-idio-24",
   427		.irq_ack = idio_24_irq_ack,
   428		.irq_mask = idio_24_irq_mask,
   429		.irq_unmask = idio_24_irq_unmask,
   430		.irq_set_type = idio_24_irq_set_type
   431	};
   432	
   433	static irqreturn_t idio_24_irq_handler(int irq, void *dev_id)
   434	{
   435		struct idio_24_gpio *const idio24gpio = dev_id;
   436		unsigned long irq_status;
   437		struct gpio_chip *const chip = &idio24gpio->chip;
   438		unsigned long irq_mask;
   439		int gpio;
   440	
   441		raw_spin_lock(&idio24gpio->lock);
   442	
   443		/* Read Change-Of-State status */
   444		irq_status = ioread32(&idio24gpio->reg->cos0_7);
   445	
   446		raw_spin_unlock(&idio24gpio->lock);
   447	
   448		/* Make sure our device generated IRQ */
   449		if (!irq_status)
   450			return IRQ_NONE;
   451	
   452		/* Handle only unmasked IRQ */
   453		irq_mask = idio24gpio->irq_mask & irq_status;
   454	
   455		for_each_set_bit(gpio, &irq_mask, chip->ngpio - 24)
   456			generic_handle_irq(irq_find_mapping(chip->irq.domain,
   457				gpio + 24));
   458	
   459		raw_spin_lock(&idio24gpio->lock);
   460	
   461		/* Clear Change-Of-State status */
   462		iowrite32(irq_status, &idio24gpio->reg->cos0_7);
   463	
   464		raw_spin_unlock(&idio24gpio->lock);
   465	
   466		return IRQ_HANDLED;
   467	}
   468	
   469	#define IDIO_24_NGPIO 56
   470	static const char *idio_24_names[IDIO_24_NGPIO] = {
   471		"OUT0", "OUT1", "OUT2", "OUT3", "OUT4", "OUT5", "OUT6", "OUT7",
   472		"OUT8", "OUT9", "OUT10", "OUT11", "OUT12", "OUT13", "OUT14", "OUT15",
   473		"OUT16", "OUT17", "OUT18", "OUT19", "OUT20", "OUT21", "OUT22", "OUT23",
   474		"IIN0", "IIN1", "IIN2", "IIN3", "IIN4", "IIN5", "IIN6", "IIN7",
   475		"IIN8", "IIN9", "IIN10", "IIN11", "IIN12", "IIN13", "IIN14", "IIN15",
   476		"IIN16", "IIN17", "IIN18", "IIN19", "IIN20", "IIN21", "IIN22", "IIN23",
   477		"TTL0", "TTL1", "TTL2", "TTL3", "TTL4", "TTL5", "TTL6", "TTL7"
   478	};
   479	
   480	static int idio_24_probe(struct pci_dev *pdev, const struct pci_device_id *id)
   481	{
   482		struct device *const dev = &pdev->dev;
   483		struct idio_24_gpio *idio24gpio;
   484		int err;
   485		const size_t pci_bar_index = 2;
   486		const char *const name = pci_name(pdev);
   487	
   488		idio24gpio = devm_kzalloc(dev, sizeof(*idio24gpio), GFP_KERNEL);
   489		if (!idio24gpio)
   490			return -ENOMEM;
   491	
   492		err = pcim_enable_device(pdev);
   493		if (err) {
   494			dev_err(dev, "Failed to enable PCI device (%d)\n", err);
   495			return err;
   496		}
   497	
   498		err = pcim_iomap_regions(pdev, BIT(pci_bar_index), name);
   499		if (err) {
   500			dev_err(dev, "Unable to map PCI I/O addresses (%d)\n", err);
   501			return err;
   502		}
   503	
   504		idio24gpio->reg = pcim_iomap_table(pdev)[pci_bar_index];
   505	
   506		idio24gpio->chip.label = name;
   507		idio24gpio->chip.parent = dev;
   508		idio24gpio->chip.owner = THIS_MODULE;
   509		idio24gpio->chip.base = -1;
   510		idio24gpio->chip.ngpio = IDIO_24_NGPIO;
   511		idio24gpio->chip.names = idio_24_names;
   512		idio24gpio->chip.get_direction = idio_24_gpio_get_direction;
   513		idio24gpio->chip.direction_input = idio_24_gpio_direction_input;
   514		idio24gpio->chip.direction_output = idio_24_gpio_direction_output;
   515		idio24gpio->chip.get = idio_24_gpio_get;
   516		idio24gpio->chip.get_multiple = idio_24_gpio_get_multiple;
   517		idio24gpio->chip.set = idio_24_gpio_set;
 > 518		idio24gpio->chip.set = idio_24_gpio_set_multiple;
   519	
   520		raw_spin_lock_init(&idio24gpio->lock);
   521	
   522		/* Software board reset */
   523		iowrite8(0, &idio24gpio->reg->soft_reset);
   524	
   525		err = devm_gpiochip_add_data(dev, &idio24gpio->chip, idio24gpio);
   526		if (err) {
   527			dev_err(dev, "GPIO registering failed (%d)\n", err);
   528			return err;
   529		}
   530	
   531		err = gpiochip_irqchip_add(&idio24gpio->chip, &idio_24_irqchip, 0,
   532			handle_edge_irq, IRQ_TYPE_NONE);
   533		if (err) {
   534			dev_err(dev, "Could not add irqchip (%d)\n", err);
   535			return err;
   536		}
   537	
   538		err = devm_request_irq(dev, pdev->irq, idio_24_irq_handler, IRQF_SHARED,
   539			name, idio24gpio);
   540		if (err) {
   541			dev_err(dev, "IRQ handler registering failed (%d)\n", err);
   542			return err;
   543		}
   544	
   545		return 0;
   546	}
   547	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
