Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C576C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A0C2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A0C2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936504AbeFRWbK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 18:31:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:42634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935073AbeFRWbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 18:31:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "To"
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BFBD0AE82;
        Mon, 18 Jun 2018 22:31:06 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     kbuild test robot <lkp@intel.com>
to:     Karsten Keil <isdn@linux-pingi.de>
Date:   Tue, 19 Jun 2018 08:30:54 +1000
Cc:     kbuild-all@01.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 2/5] kbuild: treat a directory listed in a composite object as foo/mod.a
In-Reply-To: <201806181557.lEPKCOHv%fengguang.wu@intel.com>
References: <152929772044.17463.14049121557186779554.stgit@noble> <201806181557.lEPKCOHv%fengguang.wu@intel.com>
Message-ID: <87vaafenhd.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18 2018, kbuild test robot wrote:

> Hi NeilBrown,
>
> Thank you for the patch! Yet something to improve:


Thank you for your testing and problem report! Yet something to improve:-)

This bug is caused by the combination CONFIG_MISDN_HFCUSB=3Dy and CONFIG_MI=
SDN=3Dm
and appears to have nothing to do with my patch.
I suspect drivers/isdn/hardware/mISDN/Kconfig needs

@@ -35,6 +35,7 @@ config MISDN_HFCMULTI_8xx
 config MISDN_HFCUSB
 	tristate "Support for HFC-S USB based TAs"
 	depends on USB
+	depends on MISDN
 	help
 	  Enable support for USB ISDN TAs with Cologne Chip AG's
 	  HFC-S USB ISDN Controller

or similar.

Thanks,
NeilBrown

(config file excerpt for Karsten:
CONFIG_MISDN=3Dm
CONFIG_MISDN_DSP=3Dm
CONFIG_MISDN_L1OIP=3Dm
CONFIG_MISDN_HFCPCI=3Dm
# CONFIG_MISDN_HFCMULTI is not set
CONFIG_MISDN_HFCUSB=3Dy
CONFIG_MISDN_AVMFRITZ=3Dm
CONFIG_MISDN_SPEEDFAX=3Dm
CONFIG_MISDN_INFINEON=3Dm
CONFIG_MISDN_W6692=3Dm
# CONFIG_MISDN_NETJET is not set
CONFIG_MISDN_IPAC=3Dm
CONFIG_MISDN_ISAR=3Dm
)

>
> [auto build test ERROR on kbuild/for-next]
> [also build test ERROR on v4.18-rc1 next-20180618]
> [cannot apply to mmarek/for-next mmarek/rc-fixes]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/NeilBrown/kbuild-build-m=
odules-from-code-in-multiple-directories/20180618-130250
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-k=
build.git for-next
> config: x86_64-randconfig-in0-06170623 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=3Dx86_64=20
>
> All errors (new ones prefixed by >>):
>
>    drivers/isdn/hardware/mISDN/hfcsusb.o: In function `release_hw':
>>> drivers/isdn/hardware/mISDN/hfcsusb.c:1757: undefined reference to `l1_=
event'
>>> drivers/isdn/hardware/mISDN/hfcsusb.c:1759: undefined reference to `mIS=
DN_unregister_device'
>>> drivers/isdn/hardware/mISDN/hfcsusb.c:1760: undefined reference to `mIS=
DN_freebchannel'
>    drivers/isdn/hardware/mISDN/hfcsusb.c:1761: undefined reference to `mI=
SDN_freebchannel'
>>> drivers/isdn/hardware/mISDN/hfcsusb.c:1762: undefined reference to `mIS=
DN_freedchannel'
>    drivers/isdn/hardware/mISDN/hfcsusb.o: In function `deactivate_bchanne=
l':
>>> drivers/isdn/hardware/mISDN/hfcsusb.c:1788: undefined reference to `mIS=
DN_clear_bchannel'
>    drivers/isdn/hardware/mISDN/hfcsusb.o: In function `ph_state_te':
>    drivers/isdn/hardware/mISDN/hfcsusb.c:611: undefined reference to `l1_=
event'
>    drivers/isdn/hardware/mISDN/hfcsusb.o: In function `channel_bctrl':
>>> drivers/isdn/hardware/mISDN/hfcsusb.c:808: undefined reference to `mISD=
N_ctrl_bchannel'
>    drivers/isdn/hardware/mISDN/hfcsusb.o: In function `tx_iso_complete':
>>> drivers/isdn/hardware/mISDN/hfcsusb.c:1345: undefined reference to `get=
_next_dframe'
>>> drivers/isdn/hardware/mISDN/hfcsusb.c:1348: undefined reference to `get=
_next_bframe'
>    drivers/isdn/hardware/mISDN/hfcsusb.o: In function `hfcsusb_rx_frame':
>>> drivers/isdn/hardware/mISDN/hfcsusb.c:850: undefined reference to `bcha=
nnel_get_rxbuf'
>>> drivers/isdn/hardware/mISDN/hfcsusb.c:919: undefined reference to `recv=
_Dchannel'
>>> drivers/isdn/hardware/mISDN/hfcsusb.c:921: undefined reference to `recv=
_Bchannel'
>>> drivers/isdn/hardware/mISDN/hfcsusb.c:924: undefined reference to `recv=
_Echannel'
>    drivers/isdn/hardware/mISDN/hfcsusb.c:943: undefined reference to `rec=
v_Bchannel'
>    drivers/isdn/hardware/mISDN/hfcsusb.o: In function `hfcusb_l2l1D':
>>> drivers/isdn/hardware/mISDN/hfcsusb.c:301: undefined reference to `dcha=
nnel_senddata'
>>> drivers/isdn/hardware/mISDN/hfcsusb.c:305: undefined reference to `queu=
e_ch_frame'
>    drivers/isdn/hardware/mISDN/hfcsusb.c:360: undefined reference to `l1_=
event'
>    drivers/isdn/hardware/mISDN/hfcsusb.o: In function `setup_instance':
>>> drivers/isdn/hardware/mISDN/hfcsusb.c:1843: undefined reference to `mIS=
DN_initdchannel'
>    drivers/isdn/hardware/mISDN/hfcsusb.c:1852: undefined reference to `mI=
SDN_initdchannel'
>>> drivers/isdn/hardware/mISDN/hfcsusb.c:1861: undefined reference to `mIS=
DN_initbchannel'
>>> drivers/isdn/hardware/mISDN/hfcsusb.c:1887: undefined reference to `mIS=
DN_register_device'
>    drivers/isdn/hardware/mISDN/hfcsusb.c:1898: undefined reference to `mI=
SDN_freebchannel'
>    drivers/isdn/hardware/mISDN/hfcsusb.c:1899: undefined reference to `mI=
SDN_freebchannel'
>    drivers/isdn/hardware/mISDN/hfcsusb.c:1900: undefined reference to `mI=
SDN_freedchannel'
>    drivers/isdn/hardware/mISDN/hfcsusb.o: In function `hfcusb_l2l1B':
>>> drivers/isdn/hardware/mISDN/hfcsusb.c:224: undefined reference to `bcha=
nnel_senddata'
>    drivers/isdn/hardware/mISDN/hfcsusb.o: In function `open_dchannel':
>>> drivers/isdn/hardware/mISDN/hfcsusb.c:454: undefined reference to `crea=
te_l1'
>
> vim +1757 drivers/isdn/hardware/mISDN/hfcsusb.c
>
> 69f52adb Karsten Keil  2009-01-09  1739=20=20
> 69f52adb Karsten Keil  2009-01-09  1740  static void
> 69f52adb Karsten Keil  2009-01-09  1741  release_hw(struct hfcsusb *hw)
> 69f52adb Karsten Keil  2009-01-09  1742  {
> 69f52adb Karsten Keil  2009-01-09  1743  	if (debug & DBG_HFC_CALL_TRACE)
> 69f52adb Karsten Keil  2009-01-09  1744  		printk(KERN_DEBUG "%s: %s\n", =
hw->name, __func__);
> 69f52adb Karsten Keil  2009-01-09  1745=20=20
> 69f52adb Karsten Keil  2009-01-09  1746  	/*
> 69f52adb Karsten Keil  2009-01-09  1747  	 * stop all endpoints gracefully
> 69f52adb Karsten Keil  2009-01-09  1748  	 * TODO: mISDN_core should gene=
rate CLOSE_CHANNEL
> 69f52adb Karsten Keil  2009-01-09  1749  	 *       signals after calling =
mISDN_unregister_device()
> 69f52adb Karsten Keil  2009-01-09  1750  	 */
> 69f52adb Karsten Keil  2009-01-09  1751  	hfcsusb_stop_endpoint(hw, HFC_C=
HAN_D);
> 69f52adb Karsten Keil  2009-01-09  1752  	hfcsusb_stop_endpoint(hw, HFC_C=
HAN_B1);
> 69f52adb Karsten Keil  2009-01-09  1753  	hfcsusb_stop_endpoint(hw, HFC_C=
HAN_B2);
> 69f52adb Karsten Keil  2009-01-09  1754  	if (hw->fifos[HFCUSB_PCM_RX].pi=
pe)
> 69f52adb Karsten Keil  2009-01-09  1755  		hfcsusb_stop_endpoint(hw, HFC_=
CHAN_E);
> 69f52adb Karsten Keil  2009-01-09  1756  	if (hw->protocol =3D=3D ISDN_P_=
TE_S0)
> 69f52adb Karsten Keil  2009-01-09 @1757  		l1_event(hw->dch.l1, CLOSE_CHA=
NNEL);
> 69f52adb Karsten Keil  2009-01-09  1758=20=20
> 69f52adb Karsten Keil  2009-01-09 @1759  	mISDN_unregister_device(&hw->dc=
h.dev);
> 69f52adb Karsten Keil  2009-01-09 @1760  	mISDN_freebchannel(&hw->bch[1]);
> 69f52adb Karsten Keil  2009-01-09 @1761  	mISDN_freebchannel(&hw->bch[0]);
> 69f52adb Karsten Keil  2009-01-09 @1762  	mISDN_freedchannel(&hw->dch);
> 69f52adb Karsten Keil  2009-01-09  1763=20=20
> 69f52adb Karsten Keil  2009-01-09  1764  	if (hw->ctrl_urb) {
> 69f52adb Karsten Keil  2009-01-09  1765  		usb_kill_urb(hw->ctrl_urb);
> 69f52adb Karsten Keil  2009-01-09  1766  		usb_free_urb(hw->ctrl_urb);
> 69f52adb Karsten Keil  2009-01-09  1767  		hw->ctrl_urb =3D NULL;
> 69f52adb Karsten Keil  2009-01-09  1768  	}
> 69f52adb Karsten Keil  2009-01-09  1769=20=20
> 69f52adb Karsten Keil  2009-01-09  1770  	if (hw->intf)
> 69f52adb Karsten Keil  2009-01-09  1771  		usb_set_intfdata(hw->intf, NUL=
L);
> 69f52adb Karsten Keil  2009-01-09  1772  	list_del(&hw->list);
> 69f52adb Karsten Keil  2009-01-09  1773  	kfree(hw);
> 69f52adb Karsten Keil  2009-01-09  1774  	hw =3D NULL;
> 69f52adb Karsten Keil  2009-01-09  1775  }
> 69f52adb Karsten Keil  2009-01-09  1776=20=20
> 69f52adb Karsten Keil  2009-01-09  1777  static void
> 69f52adb Karsten Keil  2009-01-09  1778  deactivate_bchannel(struct bchan=
nel *bch)
> 69f52adb Karsten Keil  2009-01-09  1779  {
> 69f52adb Karsten Keil  2009-01-09  1780  	struct hfcsusb *hw =3D bch->hw;
> 69f52adb Karsten Keil  2009-01-09  1781  	u_long flags;
> 69f52adb Karsten Keil  2009-01-09  1782=20=20
> 69f52adb Karsten Keil  2009-01-09  1783  	if (bch->debug & DEBUG_HW)
> 69f52adb Karsten Keil  2009-01-09  1784  		printk(KERN_DEBUG "%s: %s: bch=
->nr(%i)\n",
> 69f52adb Karsten Keil  2009-01-09  1785  		       hw->name, __func__, bch=
->nr);
> 69f52adb Karsten Keil  2009-01-09  1786=20=20
> 69f52adb Karsten Keil  2009-01-09  1787  	spin_lock_irqsave(&hw->lock, fl=
ags);
> fb286f04 Karsten Keil  2009-07-09 @1788  	mISDN_clear_bchannel(bch);
> 69f52adb Karsten Keil  2009-01-09  1789  	spin_unlock_irqrestore(&hw->loc=
k, flags);
> 69f52adb Karsten Keil  2009-01-09  1790  	hfcsusb_setup_bch(bch, ISDN_P_N=
ONE);
> 37952cfa Martin Bachem 2012-05-15  1791  	hfcsusb_stop_endpoint(hw, bch->=
nr - 1);
> 69f52adb Karsten Keil  2009-01-09  1792  }
> 69f52adb Karsten Keil  2009-01-09  1793=20=20
> 69f52adb Karsten Keil  2009-01-09  1794  /*
> 69f52adb Karsten Keil  2009-01-09  1795   * Layer 1 B-channel hardware ac=
cess
> 69f52adb Karsten Keil  2009-01-09  1796   */
> 69f52adb Karsten Keil  2009-01-09  1797  static int
> 69f52adb Karsten Keil  2009-01-09  1798  hfc_bctrl(struct mISDNchannel *c=
h, u_int cmd, void *arg)
> 69f52adb Karsten Keil  2009-01-09  1799  {
> 69f52adb Karsten Keil  2009-01-09  1800  	struct bchannel	*bch =3D contai=
ner_of(ch, struct bchannel, ch);
> 69f52adb Karsten Keil  2009-01-09  1801  	int		ret =3D -EINVAL;
> 69f52adb Karsten Keil  2009-01-09  1802=20=20
> 69f52adb Karsten Keil  2009-01-09  1803  	if (bch->debug & DEBUG_HW)
> 69f52adb Karsten Keil  2009-01-09  1804  		printk(KERN_DEBUG "%s: cmd:%x =
%p\n", __func__, cmd, arg);
> 69f52adb Karsten Keil  2009-01-09  1805=20=20
> 69f52adb Karsten Keil  2009-01-09  1806  	switch (cmd) {
> 69f52adb Karsten Keil  2009-01-09  1807  	case HW_TESTRX_RAW:
> 69f52adb Karsten Keil  2009-01-09  1808  	case HW_TESTRX_HDLC:
> 69f52adb Karsten Keil  2009-01-09  1809  	case HW_TESTRX_OFF:
> 69f52adb Karsten Keil  2009-01-09  1810  		ret =3D -EINVAL;
> 69f52adb Karsten Keil  2009-01-09  1811  		break;
> 69f52adb Karsten Keil  2009-01-09  1812=20=20
> 69f52adb Karsten Keil  2009-01-09  1813  	case CLOSE_CHANNEL:
> 69f52adb Karsten Keil  2009-01-09  1814  		test_and_clear_bit(FLG_OPEN, &=
bch->Flags);
> 69f52adb Karsten Keil  2009-01-09  1815  		deactivate_bchannel(bch);
> 69f52adb Karsten Keil  2009-01-09  1816  		ch->protocol =3D ISDN_P_NONE;
> 69f52adb Karsten Keil  2009-01-09  1817  		ch->peer =3D NULL;
> 69f52adb Karsten Keil  2009-01-09  1818  		module_put(THIS_MODULE);
> 69f52adb Karsten Keil  2009-01-09  1819  		ret =3D 0;
> 69f52adb Karsten Keil  2009-01-09  1820  		break;
> 69f52adb Karsten Keil  2009-01-09  1821  	case CONTROL_CHANNEL:
> 69f52adb Karsten Keil  2009-01-09  1822  		ret =3D channel_bctrl(bch, arg=
);
> 69f52adb Karsten Keil  2009-01-09  1823  		break;
> 69f52adb Karsten Keil  2009-01-09  1824  	default:
> 69f52adb Karsten Keil  2009-01-09  1825  		printk(KERN_WARNING "%s: unkno=
wn prim(%x)\n",
> 69f52adb Karsten Keil  2009-01-09  1826  		       __func__, cmd);
> 69f52adb Karsten Keil  2009-01-09  1827  	}
> 69f52adb Karsten Keil  2009-01-09  1828  	return ret;
> 69f52adb Karsten Keil  2009-01-09  1829  }
> 69f52adb Karsten Keil  2009-01-09  1830=20=20
> 69f52adb Karsten Keil  2009-01-09  1831  static int
> 69f52adb Karsten Keil  2009-01-09  1832  setup_instance(struct hfcsusb *h=
w, struct device *parent)
> 69f52adb Karsten Keil  2009-01-09  1833  {
> 69f52adb Karsten Keil  2009-01-09  1834  	u_long	flags;
> 69f52adb Karsten Keil  2009-01-09  1835  	int	err, i;
> 69f52adb Karsten Keil  2009-01-09  1836=20=20
> 69f52adb Karsten Keil  2009-01-09  1837  	if (debug & DBG_HFC_CALL_TRACE)
> 69f52adb Karsten Keil  2009-01-09  1838  		printk(KERN_DEBUG "%s: %s\n", =
hw->name, __func__);
> 69f52adb Karsten Keil  2009-01-09  1839=20=20
> 69f52adb Karsten Keil  2009-01-09  1840  	spin_lock_init(&hw->ctrl_lock);
> 69f52adb Karsten Keil  2009-01-09  1841  	spin_lock_init(&hw->lock);
> 69f52adb Karsten Keil  2009-01-09  1842=20=20
> 69f52adb Karsten Keil  2009-01-09 @1843  	mISDN_initdchannel(&hw->dch, MA=
X_DFRAME_LEN_L1, ph_state);
> 69f52adb Karsten Keil  2009-01-09  1844  	hw->dch.debug =3D debug & 0xFFF=
F;
> 69f52adb Karsten Keil  2009-01-09  1845  	hw->dch.hw =3D hw;
> 69f52adb Karsten Keil  2009-01-09  1846  	hw->dch.dev.Dprotocols =3D (1 <=
< ISDN_P_TE_S0) | (1 << ISDN_P_NT_S0);
> 69f52adb Karsten Keil  2009-01-09  1847  	hw->dch.dev.D.send =3D hfcusb_l=
2l1D;
> 69f52adb Karsten Keil  2009-01-09  1848  	hw->dch.dev.D.ctrl =3D hfc_dctr=
l;
> 69f52adb Karsten Keil  2009-01-09  1849=20=20
> 69f52adb Karsten Keil  2009-01-09  1850  	/* enable E-Channel logging */
> 69f52adb Karsten Keil  2009-01-09  1851  	if (hw->fifos[HFCUSB_PCM_RX].pi=
pe)
> 69f52adb Karsten Keil  2009-01-09 @1852  		mISDN_initdchannel(&hw->ech, M=
AX_DFRAME_LEN_L1, NULL);
> 69f52adb Karsten Keil  2009-01-09  1853=20=20
> 69f52adb Karsten Keil  2009-01-09  1854  	hw->dch.dev.Bprotocols =3D (1 <=
< (ISDN_P_B_RAW & ISDN_P_B_MASK)) |
> 69f52adb Karsten Keil  2009-01-09  1855  		(1 << (ISDN_P_B_HDLC & ISDN_P_=
B_MASK));
> 69f52adb Karsten Keil  2009-01-09  1856  	hw->dch.dev.nrbchan =3D 2;
> 69f52adb Karsten Keil  2009-01-09  1857  	for (i =3D 0; i < 2; i++) {
> 69f52adb Karsten Keil  2009-01-09  1858  		hw->bch[i].nr =3D i + 1;
> 69f52adb Karsten Keil  2009-01-09  1859  		set_channelmap(i + 1, hw->dch.=
dev.channelmap);
> 69f52adb Karsten Keil  2009-01-09  1860  		hw->bch[i].debug =3D debug;
> 034005a0 Karsten Keil  2012-05-15 @1861  		mISDN_initbchannel(&hw->bch[i]=
, MAX_DATA_MEM, poll >> 1);
> 69f52adb Karsten Keil  2009-01-09  1862  		hw->bch[i].hw =3D hw;
> 69f52adb Karsten Keil  2009-01-09  1863  		hw->bch[i].ch.send =3D hfcusb_=
l2l1B;
> 69f52adb Karsten Keil  2009-01-09  1864  		hw->bch[i].ch.ctrl =3D hfc_bct=
rl;
> 69f52adb Karsten Keil  2009-01-09  1865  		hw->bch[i].ch.nr =3D i + 1;
> 69f52adb Karsten Keil  2009-01-09  1866  		list_add(&hw->bch[i].ch.list, =
&hw->dch.dev.bchannels);
> 69f52adb Karsten Keil  2009-01-09  1867  	}
> 69f52adb Karsten Keil  2009-01-09  1868=20=20
> 69f52adb Karsten Keil  2009-01-09  1869  	hw->fifos[HFCUSB_B1_TX].bch =3D=
 &hw->bch[0];
> 69f52adb Karsten Keil  2009-01-09  1870  	hw->fifos[HFCUSB_B1_RX].bch =3D=
 &hw->bch[0];
> 69f52adb Karsten Keil  2009-01-09  1871  	hw->fifos[HFCUSB_B2_TX].bch =3D=
 &hw->bch[1];
> 69f52adb Karsten Keil  2009-01-09  1872  	hw->fifos[HFCUSB_B2_RX].bch =3D=
 &hw->bch[1];
> 69f52adb Karsten Keil  2009-01-09  1873  	hw->fifos[HFCUSB_D_TX].dch =3D =
&hw->dch;
> 69f52adb Karsten Keil  2009-01-09  1874  	hw->fifos[HFCUSB_D_RX].dch =3D =
&hw->dch;
> 69f52adb Karsten Keil  2009-01-09  1875  	hw->fifos[HFCUSB_PCM_RX].ech =
=3D &hw->ech;
> 69f52adb Karsten Keil  2009-01-09  1876  	hw->fifos[HFCUSB_PCM_TX].ech =
=3D &hw->ech;
> 69f52adb Karsten Keil  2009-01-09  1877=20=20
> 69f52adb Karsten Keil  2009-01-09  1878  	err =3D setup_hfcsusb(hw);
> 69f52adb Karsten Keil  2009-01-09  1879  	if (err)
> 69f52adb Karsten Keil  2009-01-09  1880  		goto out;
> 69f52adb Karsten Keil  2009-01-09  1881=20=20
> 69f52adb Karsten Keil  2009-01-09  1882  	snprintf(hw->name, MISDN_MAX_ID=
LEN - 1, "%s.%d", DRIVER_NAME,
> 69f52adb Karsten Keil  2009-01-09  1883  		 hfcsusb_cnt + 1);
> 69f52adb Karsten Keil  2009-01-09  1884  	printk(KERN_INFO "%s: registere=
d as '%s'\n",
> 69f52adb Karsten Keil  2009-01-09  1885  	       DRIVER_NAME, hw->name);
> 69f52adb Karsten Keil  2009-01-09  1886=20=20
> 69f52adb Karsten Keil  2009-01-09 @1887  	err =3D mISDN_register_device(&=
hw->dch.dev, parent, hw->name);
> 69f52adb Karsten Keil  2009-01-09  1888  	if (err)
> 69f52adb Karsten Keil  2009-01-09  1889  		goto out;
> 69f52adb Karsten Keil  2009-01-09  1890=20=20
> 69f52adb Karsten Keil  2009-01-09  1891  	hfcsusb_cnt++;
> 69f52adb Karsten Keil  2009-01-09  1892  	write_lock_irqsave(&HFClock, fl=
ags);
> 69f52adb Karsten Keil  2009-01-09  1893  	list_add_tail(&hw->list, &HFCli=
st);
> 69f52adb Karsten Keil  2009-01-09  1894  	write_unlock_irqrestore(&HFCloc=
k, flags);
> 69f52adb Karsten Keil  2009-01-09  1895  	return 0;
> 69f52adb Karsten Keil  2009-01-09  1896=20=20
> 69f52adb Karsten Keil  2009-01-09  1897  out:
> 69f52adb Karsten Keil  2009-01-09  1898  	mISDN_freebchannel(&hw->bch[1]);
> 69f52adb Karsten Keil  2009-01-09  1899  	mISDN_freebchannel(&hw->bch[0]);
> 69f52adb Karsten Keil  2009-01-09  1900  	mISDN_freedchannel(&hw->dch);
> 69f52adb Karsten Keil  2009-01-09  1901  	kfree(hw);
> 69f52adb Karsten Keil  2009-01-09  1902  	return err;
> 69f52adb Karsten Keil  2009-01-09  1903  }
> 69f52adb Karsten Keil  2009-01-09  1904=20=20
>
> :::::: The code at line 1757 was first introduced by commit
> :::::: 69f52adb2d534afc41fcc658f155e01f0b322f9e mISDN: Add HFC USB driver
>
> :::::: TO: Karsten Keil <kkeil@suse.de>
> :::::: CC: Karsten Keil <kkeil@suse.de>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpora=
tion

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsoMqAACgkQOeye3VZi
gbn/ehAAgu1KgKyB/JUHatsO6rigmwfmQL7JJzMIzjn9E+uh12p64vIFOJkjbrNs
nklPfQPvFLE3MnxFbSvT9bF+RfEMiF6NU3rv1JgkU+E6Z+TqSKoeH5+r+iUzybEG
JzVu0vzL0daNN6erQ41Xtf2SMWmbaWo4x0PFjIeoKNl69GK4RZCMg7xIOqZuvQyC
ESjOF35kQ3WNw+NUR43X1GarSJgJcNEs4af/hD9pVFy+jEu59zJNunJdPHih7f8v
+2cqAziJrhGCQBe6/KwyG3FmIAT1Zf2Co738a5kBHbEy/tRkW9FVXS0rLvdzJNiH
Z/Q1vsBuf7Gu334NuuZn/p8utcyHAHohEjYDw4oMEgiBbiET6JjRZCJnAxpB21Ac
W50SUhX8bL9CHremSEDMClGsNOktjl3WSiNinU2tL1Oe4g7hr/hgLX9dyjWUDi1X
k85Vsmsl1ET0BhptZeyiS+s5Xj9CTNXAe36wL0CkWVdkbDbzbDHaGoXiQXmT+Qxr
r1pf1ohGKf2ljd65Ys/T9sePk9GGi+e5LLk3KrAE312Khpp+OA2iTNpNP/4RBvEK
no6w1iqjLbQeZEiUOVqcUPcr3pnzof12LJibLAG+WmT5tOQlrDiork0qqRIiwnyU
CmcO2CxgtWl9xBSnBt4qXhc8vScXyw+OsEhimdOkxqvgcGzd0GA=
=JkYy
-----END PGP SIGNATURE-----
--=-=-=--
