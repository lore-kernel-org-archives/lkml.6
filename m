Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC76FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3B020652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RDuWBjGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3B020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeH2WB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:01:56 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39923 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeH2WB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:01:56 -0400
Received: by mail-oi0-f67.google.com with SMTP id c190-v6so10746317oig.6;
        Wed, 29 Aug 2018 11:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+VM5Xdw2bNb+i+W6ekI8RyfbFzlhVZanKFx7QbEhWg=;
        b=RDuWBjGjSAELZ0CP7DjuzPnVxJr7GfOLcVhgCnEe88/Tw3YOcqg7LCMsGhf3Hsr1dF
         BuhElIz9uTsRdHwlvGW6+98UUiCLPVnVFPCFVJRWk+xmNjyiNqbIqRPXthLYE64g+Rvi
         nDyoFeCvfUPzzTJn2+9qC6rd/m1pIyeTC5AEPinH4jLFUzd0tbsAeoWyXyYW0/7G8cv2
         sLISGU0lBzGl7dQhqvBc1Dp2sPrUOsI1gbMI01tq0sgoMrLYY/WtCjtfGCHaW59/GXZF
         58L+E6TyAVVv2FGbXfQBuDjqCLRIySKoITDmNGxBb0BXDFfnZLz1mQ0FHblJBJ9NhoCq
         OvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+VM5Xdw2bNb+i+W6ekI8RyfbFzlhVZanKFx7QbEhWg=;
        b=HvNOwutxFz+Ws5RG3rTLofdMnORU5jT+73N/3i7Kx6n3Xv1fWpzKb/FktaM/KC0N+l
         82sWSn/ivL3/NmYY81vzecSu+0f+Lc2I1RmC0z7ykvY9MjzZ3lUVbrLOLrhZuerUfCav
         eqIfnjplLpn+7bLAtF0/qd2RnYDW5s1Btc9cMV9BxELpU4LmN1S7vMQGh1GKjwMYegt5
         qRrIXT6n+yIG6nEpMRc/bNt1GTBxCgZ1PnsuK3aNnuX1LGIT4MeDHd7izcR8JDbkXiOq
         b3ve75xlGRLm9yUQ2gjj+FuTLdkgKJyjWh+YxG9MFkhuRMMvwmOJrZVMIpCOn+z8ae61
         VecQ==
X-Gm-Message-State: APzg51AQ9NuieZAXnobqYdV/Cvs8lovzvqkc/VLCBan45JQPvbb55C3f
        fjhQkp80GVKab4vlIBynSrgp4LRkk5Z7a9DLxcw=
X-Google-Smtp-Source: ANB0VdYQuHN0IcgbE3RpGYCcg4R5ZW3fCj6GGeVVwMs/vPyHnwZm6eKvtz+wuoGW7OCqBOhBLnLpC3IUFa5r/ZUdSrI=
X-Received: by 2002:aca:36d7:: with SMTP id d206-v6mr3447329oia.63.1535565832571;
 Wed, 29 Aug 2018 11:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180824090440.13411-1-jbrunet@baylibre.com> <d3858ef0-97c7-28b5-db4a-4ac71af52ba5@synopsys.com>
In-Reply-To: <d3858ef0-97c7-28b5-db4a-4ac71af52ba5@synopsys.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 29 Aug 2018 20:03:41 +0200
Message-ID: <CAFBinCA+Q6vLzutdMLOgeTDg5GBkqvp3YzBQiUd_y-qyiz=dsQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "net: stmmac: Do not keep rearming the coalesce
 timer in stmmac_xmit"
To:     Jose.Abreu@synopsys.com
Cc:     jbrunet@baylibre.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, Joao.Pinto@synopsys.com,
        clabbe@baylibre.com, linux-kernel@vger.kernel.org,
        Vitor.Soares@synopsys.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jose,

On Tue, Aug 28, 2018 at 10:12 AM Jose Abreu <Jose.Abreu@synopsys.com> wrote:
>
> Hi Jerome,
>
> On 24-08-2018 10:04, Jerome Brunet wrote:
> > This reverts commit 4ae0169fd1b3c792b66be58995b7e6b629919ecf.
> >
> > This change in the handling of the coalesce timer is causing regression on
> > (at least) amlogic platforms.
> >
> > Network will break down very quickly (a few seconds) after starting
> > a download. This can easily be reproduced using iperf3 for example.
> >
> > The problem has been reported on the S805, S905, S912 and A113 SoCs
> > (Realtek and Micrel PHYs) and it is likely impacting all Amlogics
> > platforms using Gbit ethernet
> >
> > No problem was seen with the platform using 10/100 only PHYs (GXL internal)
> >
> > Reverting change brings things back to normal and allows to use network
> > again until we better understand the problem with the coalesce timer.
> >
> >
>
> Apologies for the delayed answer but I was in FTO.
I hope you were able to enjoy your time off

> I'm not sure what can be causing this but I have some questions
> for you:
>     - What do you mean by "network will break down"? Do you see
> queue timeout?
in case of iperf3 traffic just stops

>     - What do you see in ethtool/ifconfig stats? Can you send me
> the stats before and after network break?
see below for my exact steps. let me know if you need more information
(but be prepared for some delay until I respond)

>     - Is your setup multi-queue/channel?
we don't specify anything in the .dtsi files of our platform, so the
"default" is being used

>     - Can you point me to the DT bindings of your setup?
in this specific case I used
arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts which inherits
the platform settings from arch/arm64/boot/dts/amlogic/meson-gx.dtsi
("ethmac" node)

so here's my exact steps to reproduce:
- boot the board
- IP address is auto-assigned via DHCP
- iperf3 -c 192.168.1.100
- wait until network breaks, CTRL+C
- ifconfig eth0 down
- ifconfig eth0 up
- (now Ethernet is working again)

from that point on:
# dmesg | tail -n 4
[   47.782778] RTL8211F Gigabit Ethernet 0.2009087f:00: attached PHY
driver [RTL8211F Gigabit Ethernet] (mii_bus:phy_addr=0.2009087f:00,
irq=30)
[   47.803540] meson8b-dwmac c9410000.ethernet eth0: No Safety
Features support found
[   47.805505] meson8b-dwmac c9410000.ethernet eth0: PTP not supported by HW
[   50.311975] meson8b-dwmac c9410000.ethernet eth0: Link is Up -
1Gbps/Full - flow control rx/tx

# ethtool -S eth0
NIC statistics:
     mmc_tx_octetcount_gb: 0
     mmc_tx_framecount_gb: 0
     mmc_tx_broadcastframe_g: 0
     mmc_tx_multicastframe_g: 0
     mmc_tx_64_octets_gb: 0
     mmc_tx_65_to_127_octets_gb: 0
     mmc_tx_128_to_255_octets_gb: 0
     mmc_tx_256_to_511_octets_gb: 0
     mmc_tx_512_to_1023_octets_gb: 0
     mmc_tx_1024_to_max_octets_gb: 0
     mmc_tx_unicast_gb: 0
     mmc_tx_multicast_gb: 0
     mmc_tx_broadcast_gb: 0
     mmc_tx_underflow_error: 0
     mmc_tx_singlecol_g: 0
     mmc_tx_multicol_g: 0
     mmc_tx_deferred: 0
     mmc_tx_latecol: 0
     mmc_tx_exesscol: 0
     mmc_tx_carrier_error: 0
     mmc_tx_octetcount_g: 0
     mmc_tx_framecount_g: 0
     mmc_tx_excessdef: 0
     mmc_tx_pause_frame: 0
     mmc_tx_vlan_frame_g: 0
     mmc_rx_framecount_gb: 43
     mmc_rx_octetcount_gb: 3096
     mmc_rx_octetcount_g: 3096
     mmc_rx_broadcastframe_g: 38
     mmc_rx_multicastframe_g: 0
     mmc_rx_crc_error: 0
     mmc_rx_align_error: 0
     mmc_rx_run_error: 0
     mmc_rx_jabber_error: 0
     mmc_rx_undersize_g: 0
     mmc_rx_oversize_g: 0
     mmc_rx_64_octets_gb: 29
     mmc_rx_65_to_127_octets_gb: 13
     mmc_rx_128_to_255_octets_gb: 0
     mmc_rx_256_to_511_octets_gb: 1
     mmc_rx_512_to_1023_octets_gb: 0
     mmc_rx_1024_to_max_octets_gb: 0
     mmc_rx_unicast_g: 5
     mmc_rx_length_error: 0
     mmc_rx_autofrangetype: 0
     mmc_rx_pause_frames: 0
     mmc_rx_fifo_overflow: 0
     mmc_rx_vlan_frames_gb: 0
     mmc_rx_watchdog_error: 0
     mmc_rx_ipc_intr_mask: 1073692671
     mmc_rx_ipc_intr: 0
     mmc_rx_ipv4_gd: 15
     mmc_rx_ipv4_hderr: 0
     mmc_rx_ipv4_nopay: 0
     mmc_rx_ipv4_frag: 0
     mmc_rx_ipv4_udsbl: 0
     mmc_rx_ipv4_gd_octets: 1028
     mmc_rx_ipv4_hderr_octets: 0
     mmc_rx_ipv4_nopay_octets: 0
     mmc_rx_ipv4_frag_octets: 0
     mmc_rx_ipv4_udsbl_octets: 0
     mmc_rx_ipv6_gd_octets: 0
     mmc_rx_ipv6_hderr_octets: 0
     mmc_rx_ipv6_nopay_octets: 0
     mmc_rx_ipv6_gd: 0
     mmc_rx_ipv6_hderr: 0
     mmc_rx_ipv6_nopay: 0
     mmc_rx_udp_gd: 11
     mmc_rx_udp_err: 0
     mmc_rx_tcp_gd: 4
     mmc_rx_tcp_err: 0
     mmc_rx_icmp_gd: 0
     mmc_rx_icmp_err: 0
     mmc_rx_udp_gd_octets: 592
     mmc_rx_udp_err_octets: 0
     mmc_rx_tcp_gd_octets: 136
     mmc_rx_tcp_err_octets: 0
     mmc_rx_icmp_gd_octets: 0
     mmc_rx_icmp_err_octets: 0
     tx_underflow: 0
     tx_carrier: 0
     tx_losscarrier: 0
     vlan_tag: 0
     tx_deferred: 0
     tx_vlan: 0
     tx_jabber: 0
     tx_frame_flushed: 0
     tx_payload_error: 0
     tx_ip_header_error: 0
     rx_desc: 0
     sa_filter_fail: 0
     overflow_error: 0
     ipc_csum_error: 0
     rx_collision: 0
     rx_crc_errors: 0
     dribbling_bit: 0
     rx_length: 0
     rx_mii: 0
     rx_multicast: 0
     rx_gmac_overflow: 0
     rx_watchdog: 0
     da_rx_filter_fail: 0
     sa_rx_filter_fail: 0
     rx_missed_cntr: 0
     rx_overflow_cntr: 0
     rx_vlan: 0
     tx_undeflow_irq: 0
     tx_process_stopped_irq: 0
     tx_jabber_irq: 0
     rx_overflow_irq: 0
     rx_buf_unav_irq: 0
     rx_process_stopped_irq: 0
     rx_watchdog_irq: 0
     tx_early_irq: 0
     fatal_bus_error_irq: 0
     rx_early_irq: 0
     threshold: 1
     tx_pkt_n: 8
     rx_pkt_n: 43
     normal_irq_n: 38
     rx_normal_irq_n: 34
     napi_poll: 38
     tx_normal_irq_n: 4
     tx_clean: 43
     tx_set_ic_bit: 4
     irq_receive_pmt_irq_n: 0
     mmc_tx_irq_n: 0
     mmc_rx_irq_n: 0
     mmc_rx_csum_offload_irq_n: 0
     irq_tx_path_in_lpi_mode_n: 0
     irq_tx_path_exit_lpi_mode_n: 0
     irq_rx_path_in_lpi_mode_n: 0
     irq_rx_path_exit_lpi_mode_n: 0
     phy_eee_wakeup_error_n: 0
     ip_hdr_err: 0
     ip_payload_err: 0
     ip_csum_bypassed: 0
     ipv4_pkt_rcvd: 0
     ipv6_pkt_rcvd: 0
     no_ptp_rx_msg_type_ext: 0
     ptp_rx_msg_type_sync: 0
     ptp_rx_msg_type_follow_up: 0
     ptp_rx_msg_type_delay_req: 0
     ptp_rx_msg_type_delay_resp: 0
     ptp_rx_msg_type_pdelay_req: 0
     ptp_rx_msg_type_pdelay_resp: 0
     ptp_rx_msg_type_pdelay_follow_up: 0
     ptp_rx_msg_type_announce: 0
     ptp_rx_msg_type_management: 0
     ptp_rx_msg_pkt_reserved_type: 0
     ptp_frame_type: 0
     ptp_ver: 0
     timestamp_dropped: 0
     av_pkt_rcvd: 0
     av_tagged_pkt_rcvd: 0
     vlan_tag_priority_val: 0
     l3_filter_match: 0
     l4_filter_match: 0
     l3_l4_filter_no_match: 0
     irq_pcs_ane_n: 0
     irq_pcs_link_n: 0
     irq_rgmii_n: 0
     mtl_tx_status_fifo_full: 0
     mtl_tx_fifo_not_empty: 0
     mmtl_fifo_ctrl: 0
     mtl_tx_fifo_read_ctrl_write: 0
     mtl_tx_fifo_read_ctrl_wait: 0
     mtl_tx_fifo_read_ctrl_read: 0
     mtl_tx_fifo_read_ctrl_idle: 0
     mac_tx_in_pause: 0
     mac_tx_frame_ctrl_xfer: 0
     mac_tx_frame_ctrl_idle: 0
     mac_tx_frame_ctrl_wait: 0
     mac_tx_frame_ctrl_pause: 0
     mac_gmii_tx_proto_engine: 0
     mtl_rx_fifo_fill_level_full: 0
     mtl_rx_fifo_fill_above_thresh: 0
     mtl_rx_fifo_fill_below_thresh: 0
     mtl_rx_fifo_fill_level_empty: 0
     mtl_rx_fifo_read_ctrl_flush: 0
     mtl_rx_fifo_read_ctrl_read_data: 0
     mtl_rx_fifo_read_ctrl_status: 0
     mtl_rx_fifo_read_ctrl_idle: 0
     mtl_rx_fifo_ctrl_active: 0
     mac_rx_frame_ctrl_fifo: 0
     mac_gmii_rx_proto_engine: 0
     tx_tso_frames: 0
     tx_tso_nfrags: 0
# ethtool eth0
Settings for eth0:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Advertised pause frame use: No
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Link partner advertised link modes:  10baseT/Half 10baseT/Full
                                             100baseT/Half 100baseT/Full
                                             1000baseT/Full
        Link partner advertised pause frame use: Symmetric Receive-only
        Link partner advertised auto-negotiation: Yes
        Link partner advertised FEC modes: Not reported
        Speed: 1000Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: on
        Supports Wake-on: ug
        Wake-on: d
        Current message level: 0x0000003f (63)
                               drv probe link timer ifdown ifup
        Link detected: yes
# ifconfig eth0
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.116  netmask 255.255.255.0  broadcast 192.168.1.255
        ether 66:d8:d0:34:f1:cb  txqueuelen 1000  (Ethernet)
        RX packets 4420  bytes 292864 (286.0 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 19165  bytes 28975001 (27.6 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 21

# iperf3 -c 192.168.1.100
Connecting to host 192.168.1.100, port 5201
[  5] local 192.168.1.116 port 50608 connected to 192.168.1.100 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   111 MBytes   932 Mbits/sec    1    338 KBytes
[  5]   1.00-2.00   sec   111 MBytes   930 Mbits/sec    0    351 KBytes
[  5]   2.00-3.00   sec   112 MBytes   938 Mbits/sec    0    375 KBytes
[  5]   3.00-4.00   sec   112 MBytes   943 Mbits/sec    0    390 KBytes
[  5]   4.00-5.00   sec  50.3 MBytes   421 Mbits/sec    1   1.41 KBytes
[  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes
[  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
[  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
[  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
[  5]  10.00-29.11  sec  0.00 Bytes  0.00 bits/sec    2   1.41 KBytes
<CTRL+C after ~30 seconds>
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-29.11  sec   496 MBytes   143 Mbits/sec    5             sender
[  5]   0.00-29.11  sec  0.00 Bytes  0.00 bits/sec                  receiver
iperf3: interrupt - the client has terminated

# ethtool -S eth0
NIC statistics:
     mmc_tx_octetcount_gb: 0
     mmc_tx_framecount_gb: 0
     mmc_tx_broadcastframe_g: 0
     mmc_tx_multicastframe_g: 0
     mmc_tx_64_octets_gb: 0
     mmc_tx_65_to_127_octets_gb: 0
     mmc_tx_128_to_255_octets_gb: 0
     mmc_tx_256_to_511_octets_gb: 0
     mmc_tx_512_to_1023_octets_gb: 0
     mmc_tx_1024_to_max_octets_gb: 0
     mmc_tx_unicast_gb: 0
     mmc_tx_multicast_gb: 0
     mmc_tx_broadcast_gb: 0
     mmc_tx_underflow_error: 0
     mmc_tx_singlecol_g: 0
     mmc_tx_multicol_g: 0
     mmc_tx_deferred: 0
     mmc_tx_latecol: 0
     mmc_tx_exesscol: 0
     mmc_tx_carrier_error: 0
     mmc_tx_octetcount_g: 0
     mmc_tx_framecount_g: 0
     mmc_tx_excessdef: 0
     mmc_tx_pause_frame: 0
     mmc_tx_vlan_frame_g: 0
     mmc_rx_framecount_gb: 16766
     mmc_rx_octetcount_gb: 1173986
     mmc_rx_octetcount_g: 1173986
     mmc_rx_broadcastframe_g: 98
     mmc_rx_multicastframe_g: 0
     mmc_rx_crc_error: 0
     mmc_rx_align_error: 0
     mmc_rx_run_error: 0
     mmc_rx_jabber_error: 0
     mmc_rx_undersize_g: 0
     mmc_rx_oversize_g: 0
     mmc_rx_64_octets_gb: 96
     mmc_rx_65_to_127_octets_gb: 16669
     mmc_rx_128_to_255_octets_gb: 0
     mmc_rx_256_to_511_octets_gb: 1
     mmc_rx_512_to_1023_octets_gb: 0
     mmc_rx_1024_to_max_octets_gb: 0
     mmc_rx_unicast_g: 16668
     mmc_rx_length_error: 0
     mmc_rx_autofrangetype: 0
     mmc_rx_pause_frames: 0
     mmc_rx_fifo_overflow: 0
     mmc_rx_vlan_frames_gb: 0
     mmc_rx_watchdog_error: 0
     mmc_rx_ipc_intr_mask: 2147385342
     mmc_rx_ipc_intr: 0
     mmc_rx_ipv4_gd: 16671
     mmc_rx_ipv4_hderr: 0
     mmc_rx_ipv4_nopay: 0
     mmc_rx_ipv4_frag: 0
     mmc_rx_ipv4_udsbl: 0
     mmc_rx_ipv4_gd_octets: 867822
     mmc_rx_ipv4_hderr_octets: 0
     mmc_rx_ipv4_nopay_octets: 0
     mmc_rx_ipv4_frag_octets: 0
     mmc_rx_ipv4_udsbl_octets: 0
     mmc_rx_ipv6_gd_octets: 0
     mmc_rx_ipv6_hderr_octets: 0
     mmc_rx_ipv6_nopay_octets: 0
     mmc_rx_ipv6_gd: 0
     mmc_rx_ipv6_hderr: 0
     mmc_rx_ipv6_nopay: 0
     mmc_rx_udp_gd: 28
     mmc_rx_udp_err: 0
     mmc_rx_tcp_gd: 16643
     mmc_rx_tcp_err: 0
     mmc_rx_icmp_gd: 0
     mmc_rx_icmp_err: 0
     mmc_rx_udp_gd_octets: 1068
     mmc_rx_udp_err_octets: 0
     mmc_rx_tcp_gd_octets: 533334
     mmc_rx_tcp_err_octets: 0
     mmc_rx_icmp_gd_octets: 0
     mmc_rx_icmp_err_octets: 0
     tx_underflow: 0
     tx_carrier: 0
     tx_losscarrier: 0
     vlan_tag: 0
     tx_deferred: 0
     tx_vlan: 0
     tx_jabber: 0
     tx_frame_flushed: 0
     tx_payload_error: 0
     tx_ip_header_error: 0
     rx_desc: 0
     sa_filter_fail: 0
     overflow_error: 0
     ipc_csum_error: 0
     rx_collision: 0
     rx_crc_errors: 0
     dribbling_bit: 0
     rx_length: 0
     rx_mii: 0
     rx_multicast: 0
     rx_gmac_overflow: 0
     rx_watchdog: 0
     da_rx_filter_fail: 0
     sa_rx_filter_fail: 0
     rx_missed_cntr: 0
     rx_overflow_cntr: 0
     rx_vlan: 0
     tx_undeflow_irq: 0
     tx_process_stopped_irq: 0
     tx_jabber_irq: 0
     rx_overflow_irq: 0
     rx_buf_unav_irq: 0
     rx_process_stopped_irq: 0
     rx_watchdog_irq: 0
     tx_early_irq: 0
     fatal_bus_error_irq: 0
     rx_early_irq: 11717
     threshold: 1
     tx_pkt_n: 359107
     rx_pkt_n: 16660
     normal_irq_n: 108987
     rx_normal_irq_n: 7449
     napi_poll: 107154
     tx_normal_irq_n: 105918
     tx_clean: 107179
     tx_set_ic_bit: 179554
     irq_receive_pmt_irq_n: 0
     mmc_tx_irq_n: 0
     mmc_rx_irq_n: 0
     mmc_rx_csum_offload_irq_n: 0
     irq_tx_path_in_lpi_mode_n: 0
     irq_tx_path_exit_lpi_mode_n: 0
     irq_rx_path_in_lpi_mode_n: 0
     irq_rx_path_exit_lpi_mode_n: 0
     phy_eee_wakeup_error_n: 0
     ip_hdr_err: 0
     ip_payload_err: 0
     ip_csum_bypassed: 0
     ipv4_pkt_rcvd: 0
     ipv6_pkt_rcvd: 0
     no_ptp_rx_msg_type_ext: 0
     ptp_rx_msg_type_sync: 0
     ptp_rx_msg_type_follow_up: 0
     ptp_rx_msg_type_delay_req: 0
     ptp_rx_msg_type_delay_resp: 0
     ptp_rx_msg_type_pdelay_req: 0
     ptp_rx_msg_type_pdelay_resp: 0
     ptp_rx_msg_type_pdelay_follow_up: 0
     ptp_rx_msg_type_announce: 0
     ptp_rx_msg_type_management: 0
     ptp_rx_msg_pkt_reserved_type: 0
     ptp_frame_type: 0
     ptp_ver: 0
     timestamp_dropped: 0
     av_pkt_rcvd: 0
     av_tagged_pkt_rcvd: 0
     vlan_tag_priority_val: 0
     l3_filter_match: 0
     l4_filter_match: 0
     l3_l4_filter_no_match: 0
     irq_pcs_ane_n: 0
     irq_pcs_link_n: 0
     irq_rgmii_n: 0
     mtl_tx_status_fifo_full: 0
     mtl_tx_fifo_not_empty: 0
     mmtl_fifo_ctrl: 0
     mtl_tx_fifo_read_ctrl_write: 0
     mtl_tx_fifo_read_ctrl_wait: 0
     mtl_tx_fifo_read_ctrl_read: 0
     mtl_tx_fifo_read_ctrl_idle: 0
     mac_tx_in_pause: 0
     mac_tx_frame_ctrl_xfer: 0
     mac_tx_frame_ctrl_idle: 0
     mac_tx_frame_ctrl_wait: 0
     mac_tx_frame_ctrl_pause: 0
     mac_gmii_tx_proto_engine: 0
     mtl_rx_fifo_fill_level_full: 0
     mtl_rx_fifo_fill_above_thresh: 0
     mtl_rx_fifo_fill_below_thresh: 0
     mtl_rx_fifo_fill_level_empty: 0
     mtl_rx_fifo_read_ctrl_flush: 0
     mtl_rx_fifo_read_ctrl_read_data: 0
     mtl_rx_fifo_read_ctrl_status: 0
     mtl_rx_fifo_read_ctrl_idle: 0
     mtl_rx_fifo_ctrl_active: 0
     mac_rx_frame_ctrl_fifo: 0
     mac_gmii_rx_proto_engine: 0
     tx_tso_frames: 0
     tx_tso_nfrags: 0
# ethtool eth0
Settings for eth0:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Advertised pause frame use: No
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Link partner advertised link modes:  10baseT/Half 10baseT/Full
                                             100baseT/Half 100baseT/Full
                                             1000baseT/Full
        Link partner advertised pause frame use: Symmetric Receive-only
        Link partner advertised auto-negotiation: Yes
        Link partner advertised FEC modes: Not reported
        Speed: 1000Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: on
        Supports Wake-on: ug
        Wake-on: d
        Current message level: 0x0000003f (63)
                               drv probe link timer ifdown ifup
        Link detected: yes
# ifconfig eth0
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.116  netmask 255.255.255.0  broadcast 192.168.1.255
        ether 66:d8:d0:34:f1:cb  txqueuelen 1000  (Ethernet)
        RX packets 21021  bytes 1389130 (1.3 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 378272  bytes 572598814 (546.0 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 21


Regards
Martin
