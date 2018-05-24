Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970921AbeEXPaP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 11:30:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:9286 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S966825AbeEXPaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 11:30:11 -0400
X-UUID: 8f5b5286c283418c8a3201472993a425-20180524
Message-ID: <1527175805.4607.103.camel@mtkswgap22>
Subject: Re: [PATCH v2 4/7] Bluetooth: Add new quirk for non-persistent
 setup settings
From: Sean Wang <sean.wang@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-mediatek@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Date: Thu, 24 May 2018 23:30:05 +0800
In-Reply-To: <37400FCE-8F9A-433B-8E3A-DE9CBEB469D7@holtmann.org>
References: <cover.1526374087.git.sean.wang@mediatek.com>
         <1d6097f538b3182b2876ad48225ecd6e2d1b128c.1526374087.git.sean.wang@mediatek.com>
         <920B3BE9-3FE8-4AC6-8C5F-63B0E00182AC@holtmann.org>
         <1526976323.18877.47.camel@mtkswgap22> <1527057423.4607.3.camel@mtkswgap22>
         <B82BB5F4-E197-4915-A543-C5FF9A5A41F1@holtmann.org>
         <1527084544.4607.8.camel@mtkswgap22>
         <37400FCE-8F9A-433B-8E3A-DE9CBEB469D7@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-24 at 09:47 +0200, Marcel Holtmann wrote:
> Hi Sean,
> 
> >>>> 
> >>>> [ ... ]

[ ... ]

> > I post it as plain text as below 
> > 
> > 
> > Bluetooth monitor ver 5.37
> > = Note: Linux version 4.16.0-rc1+ (aarch64)                            0.641494
> > = Note: Bluetooth subsystem version 2.22                               0.641502
> > = New Index: 00:00:46:76:22:01 (BR/EDR,UART,hci0)               [hci0] 0.641505
> > * Unknown packet (code 14 len 30)                                      0.641509
> >        01 00 00 00 02 00 01 0e 00 01 00 00 00 10 62 6c  ..............bl
> >        75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> > * Unknown packet (code 14 len 30)                                      0.641592
> >        02 00 00 00 02 00 01 0e 00 01 00 00 00 10 62 74  ..............bt
> >        6d 6f 6e 00 00 00 00 00 00 00 00 00 00 00        mon...........  
> > * Unknown packet (code 16 len 7)                                [hci0] 6.536771
> >        01 00 00 00 05 00 01                             .......         
> > = Open Index: 00:00:46:76:22:01                                 [hci0] 6.717019
> > = Index Info: 00:00:46:76:22:01 (MediaTek, Inc.)                [hci0] 6.717030
> 
> can you try with the latest BlueZ 5.49 or git version. Seems it actually stumbles over the extra packet here. Fun fact is that I can not get a backtrace to pin-point the issue in btmon and why it crashes.
> 

I had less experience updating user land BlueZ, but I can try it as possible and see whether Unknown packets still are present at newest version BlueZ. Hopefully I don't misunderstand your point here. 


> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.741093
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.742088
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.743102
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.744105
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.745109
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.746104
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.747097
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.748090
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.749078
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.750070
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.751061
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.752054
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.753046
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.754038
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.755031
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.756025
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.757013
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.758006
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.758999
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.759991
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.760983
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.761975
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.762963
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.763956
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.764948
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.765941
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.766933
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.767926
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.768919
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.769914
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.770909
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.771908
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.772904
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.773898
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.774892
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.775890
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.776882
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.777877
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.778871
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.779869
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.780864
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.781858
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.782852
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.783850
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.784845
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.785839
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.786833
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.787831
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.788826
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.789820
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.790814
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.791813
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.792809
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.793803
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.794798
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.795797
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.796791
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.797786
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.798779
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.799778
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.800774
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.801769
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.802763
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.803761
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.804755
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.805749
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.806743
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.807741
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.808737
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.809731
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.810725
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.811725
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.812719
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.813714
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.814708
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.815705
> >        02 01 01 00 00                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.816378
> >        02 01 01 00 00                                   .....           
> 
> Why do I see only HCI events here? Is this event conveying any useful information. It is kinda complicated that this is 0xe4 event code which is actually reserved for future use by the Bluetooth SIG. Are there any accompanying HCI commands for this and they just not make it into btmon?
> 

I have made all vendor HCI commands go through BlueZ core in v2 patch. 

And for these HCI events, they are all corresponding to vendor ACL data, applied only to firmware setup packets, but they're not being sent via BlueZ core, so they are not being logged in btmon.

As for its event, where heading 0xe4 refers to a vendor event and is used on notification of that either vendor ACL data or vendor HCI command have been done.

> 
> 
> > < HCI Command: Vendor (0x3f|0x006f) plen 5                      [hci0] 6.816413
> >        01 07 01 00 04                                   .....           
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.816536
> >        02 07 01 00 00                                   .....           
> > < HCI Command: Vendor (0x3f|0x006f) plen 6                      [hci0] 8.845071
> >        01 06 02 00 00 01                                ......          
> >> HCI Event: Unknown (0xe4) plen 5                              [hci0] 8.923456
> >        02 06 01 00 00                                   .....           
> 
> Here it looks like you have 0x006f opcode with first octet 0x01 for command and then vendor event 0xe4 with first octet 0x02 for event. I assume the second octet is then the vendor command code for these.
> 

Yes, you're right.

> > < HCI Command: Reset (0x03|0x0003) plen 0                      [hci0] 10.861118
> >> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 10.865763
> >      Reset (0x03|0x0003) ncmd 1
> >        Status: Success (0x00)
> > < HCI Command: Read Local Supported Fe.. (0x04|0x0003) plen 0  [hci0] 10.865805
> >> HCI Event: Command Complete (0x0e) plen 12                   [hci0] 10.865965
> >      Read Local Supported Features (0x04|0x0003) ncmd 1
> >        Status: Success (0x00)
> >        Features: 0xbf 0x3e 0x8d 0xfe 0xdb 0xff 0x7b 0x87
> >          3 slot packets
> >          5 slot packets
> >          Encryption
> >          Slot offset
> >          Timing accuracy
> >          Role switch
> >          Sniff mode
> >          Power control requests
> >          Channel quality driven data rate (CQDDR)
> >          SCO link
> >          HV2 packets
> >          HV3 packets
> >          CVSD synchronous data
> >          Power control
> >          Transparent synchronous data
> >          Broadcast Encryption
> >          Enhanced Data Rate ACL 2 Mbps mode
> >          Enhanced Data Rate ACL 3 Mbps mode
> >          Enhanced inquiry scan
> >          Interlaced inquiry scan
> >          Interlaced page scan
> >          RSSI with inquiry results
> >          Extended SCO link (EV3 packets)
> >          EV4 packets
> >          EV5 packets
> >          AFH capable slave
> >          AFH classification slave
> >          LE Supported (Controller)
> >          3-slot Enhanced Data Rate ACL packets
> >          5-slot Enhanced Data Rate ACL packets
> >          Sniff subrating
> >          Pause encryption
> >          AFH capable master
> >          AFH classification master
> >          Enhanced Data Rate eSCO 2 Mbps mode
> >          Enhanced Data Rate eSCO 3 Mbps mode
> >          3-slot Enhanced Data Rate eSCO packets
> >          Extended Inquiry Response
> >          Simultaneous LE and BR/EDR (Controller)
> >          Secure Simple Pairing
> >          Encapsulated PDU
> >          Erroneous Data Reporting
> >          Non-flushable Packet Boundary Flag
> >          Link Supervision Timeout Changed Event
> >          Inquiry TX Power Level
> >          Enhanced Power Control
> >          Extended features
> > < HCI Command: Read Local Version Info.. (0x04|0x0001) plen 0  [hci0] 10.865987
> >> HCI Event: Vendor (0xff) plen 9                              [hci0] 10.866259
> >        29 19 09 17 20 48 07 11 00                       )... H…       
> 
> Is this meant to happen here?
> 

If event received is not expected as the specification defines, I think it's probably incorrect.

But it requires more discussion with firmware people to make it clearer.

> >> HCI Event: Command Complete (0x0e) plen 12                   [hci0] 10.866372
> >      Read Local Version Information (0x04|0x0001) ncmd 1
> >        Status: Success (0x00)
> >        HCI version: Bluetooth 4.2 (0x08) - Revision 4359 (0x1107)
> >        LMP version: Bluetooth 4.2 (0x08) - Subversion 2329 (0x0919)
> >        Manufacturer: MediaTek, Inc. (70)
> > < HCI Command: Read BD ADDR (0x04|0x0009) plen 0               [hci0] 10.866391
> >> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 10.866539
> >      Read BD ADDR (0x04|0x0009) ncmd 1
> >        Status: Success (0x00)
> >        Address: 00:00:46:76:22:01 (OLIVETTI NORTH AMERICA)
> > < HCI Command: Read Buffer Size (0x04|0x0005) plen 0           [hci0] 10.866609
> >> HCI Event: Command Complete (0x0e) plen 11                   [hci0] 10.866754
> >      Read Buffer Size (0x04|0x0005) ncmd 1
> >        Status: Success (0x00)
> >        ACL MTU: 1021 ACL max packet: 8
> >        SCO MTU: 184  SCO max packet: 1
> > < HCI Command: Read Class of Device (0x03|0x0023) plen 0       [hci0] 10.866775
> >> HCI Event: Command Complete (0x0e) plen 7                    [hci0] 10.866920
> >      Read Class of Device (0x03|0x0023) ncmd 1
> >        Status: Success (0x00)
> >        Class: 0x001f00
> >          Major class: Uncategorized, specific device code not specified
> >          Minor class: 0x00
> > < HCI Command: Read Local Name (0x03|0x0014) plen 0            [hci0] 10.866939
> >> HCI Event: Command Complete (0x0e) plen 252                  [hci0] 10.867256
> >      Read Local Name (0x03|0x0014) ncmd 1
> >        Status: Success (0x00)
> >        Name: MTK MT7622 #1
> > < HCI Command: Read Voice Setting (0x03|0x0025) plen 0         [hci0] 10.867308
> >> HCI Event: Command Complete (0x0e) plen 6                    [hci0] 10.867447
> >      Read Voice Setting (0x03|0x0025) ncmd 1
> >        Status: Success (0x00)
> >        Setting: 0x0060
> >          Input Coding: Linear
> >          Input Data Format: 2's complement
> >          Input Sample Size: 16-bit
> >          # of bits padding at MSB: 0
> >          Air Coding Format: CVSD
> > < HCI Command: Read Number of Supporte.. (0x03|0x0038) plen 0  [hci0] 10.867474
> >> HCI Event: Command Complete (0x0e) plen 5                    [hci0] 10.867611
> >      Read Number of Supported IAC (0x03|0x0038) ncmd 1
> >        Status: Success (0x00)
> >        Number of IAC: 4
> > < HCI Command: Read Current IAC LAP (0x03|0x0039) plen 0       [hci0] 10.867678
> >> HCI Event: Command Complete (0x0e) plen 8                    [hci0] 10.867865
> >      Read Current IAC LAP (0x03|0x0039) ncmd 1
> >        Status: Success (0x00)
> >        Number of IAC: 1
> >        Access code: 0x9e8b33 (General Inquiry)
> > < HCI Command: Set Event Filter (0x03|0x0005) plen 1           [hci0] 10.867890
> >        Type: Clear All Filters (0x00)
> >> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 10.868033
> >      Set Event Filter (0x03|0x0005) ncmd 1
> >        Status: Success (0x00)
> > < HCI Command: Write Connection Accept.. (0x03|0x0016) plen 2  [hci0] 10.868054
> >        Timeout: 20000.000 msec (0x7d00)
> >> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 10.868235
> >      Write Connection Accept Timeout (0x03|0x0016) ncmd 1
> >        Status: Success (0x00)
> > < HCI Command: LE Read Buffer Size (0x08|0x0002) plen 0        [hci0] 10.868262
> >> HCI Event: Command Complete (0x0e) plen 7                    [hci0] 10.868392
> >      LE Read Buffer Size (0x08|0x0002) ncmd 1
> >        Status: Success (0x00)
> >        Data packet length: 251
> >        Num data packets: 8
> > < HCI Command: LE Read Local Supported.. (0x08|0x0003) plen 0  [hci0] 10.868413
> >> HCI Event: Command Complete (0x0e) plen 12                   [hci0] 10.868587
> >      LE Read Local Supported Features (0x08|0x0003) ncmd 1
> >        Status: Success (0x00)
> >        Features: 0xfd 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> >          LE Encryption
> >          Extended Reject Indication
> >          Slave-initiated Features Exchange
> >          LE Ping
> >          LE Data Packet Length Extension
> >          LL Privacy
> >          Extended Scanner Filter Policies
> > < HCI Command: LE Read Supported States (0x08|0x001c) plen 0   [hci0] 10.868646
> >> HCI Event: Command Complete (0x0e) plen 12                   [hci0] 10.868787
> >      LE Read Supported States (0x08|0x001c) ncmd 1
> >        Status: Success (0x00)
> >        States: 0x000000001fffffff
> >          Non-connectable Advertising State
> >          Scannable Advertising State
> >          Connectable Advertising State
> >          High Duty Cycle Directed Advertising State
> >          Passive Scanning State
> >          Active Scanning State
> >          Initiating State
> >            and Connection State (Master Role)
> >          Connection State (Slave Role)
> >          Non-connectable Advertising State
> >            and Passive Scanning State
> >          Scannable Advertising State
> >            and Passive Scanning State
> >          Connectable Advertising State
> >            and Passive Scanning State
> >          High Duty Cycle Directed Advertising State
> >            and Passive Scanning State
> >          Non-connectable Advertising State
> >            and Active Scanning State
> >          Scannable Advertising State
> >            and Active Scanning State
> >          Connectable Advertising State
> >            and Active Scanning State
> >          High Duty Cycle Directed Advertising State
> >            and Active Scanning State
> >          Non-connectable Advertising State
> >            and Initiating State
> >          Scannable Advertising State
> >            and Initiating State
> >          Non-connectable Advertising State
> >            and Connection State (Master Role)
> >          Scannable Advertising State
> >            and Connection State (Master Role)
> >          Non-connectable Advertising State
> >            and Connection State (Slave Role)
> >          Scannable Advertising State
> >            and Connection State (Slave Role)
> >          Passive Scanning State
> >            and Initiating State
> >          Active Scanning State
> >            and Initiating State
> >          Passive Scanning State
> >            and Connection State (Master Role)
> >          Active Scanning State
> >            and Connection State (Master Role)
> >          Passive Scanning State
> >            and Connection State (Slave Role)
> >          Active Scanning State
> >            and Connection State (Slave Role)
> >          Initiating State
> >            and Connection State (Master Role)
> >            and Master Role & Master Role
> > < HCI Command: Read Local Supported Co.. (0x04|0x0002) plen 0  [hci0] 10.868807
> >> HCI Event: Command Complete (0x0e) plen 68                   [hci0] 10.868985
> >      Read Local Supported Commands (0x04|0x0002) ncmd 1
> >        Status: Success (0x00)
> >        Commands: 176 entries
> >          Inquiry (Octet 0 - Bit 0)
> >          Inquiry Cancel (Octet 0 - Bit 1)
> >          Periodic Inquiry Mode (Octet 0 - Bit 2)
> >          Exit Periodic Inquiry Mode (Octet 0 - Bit 3)
> >          Create Connection (Octet 0 - Bit 4)
> >          Disconnect (Octet 0 - Bit 5)
> >          Add SCO Connection (Octet 0 - Bit 6)
> >          Create Connection Cancel (Octet 0 - Bit 7)
> >          Accept Connection Request (Octet 1 - Bit 0)
> >          Reject Connection Request (Octet 1 - Bit 1)
> >          Link Key Request Reply (Octet 1 - Bit 2)
> >          Link Key Request Negative Reply (Octet 1 - Bit 3)
> >          PIN Code Request Reply (Octet 1 - Bit 4)
> >          PIN Code Request Negative Reply (Octet 1 - Bit 5)
> >          Change Connection Packet Type (Octet 1 - Bit 6)
> >          Authentication Requested (Octet 1 - Bit 7)
> >          Set Connection Encryption (Octet 2 - Bit 0)
> >          Change Connection Link Key (Octet 2 - Bit 1)
> >          Master Link Key (Octet 2 - Bit 2)
> >          Remote Name Request (Octet 2 - Bit 3)
> >          Remote Name Request Cancel (Octet 2 - Bit 4)
> >          Read Remote Supported Features (Octet 2 - Bit 5)
> >          Read Remote Extended Features (Octet 2 - Bit 6)
> >          Read Remote Version Information (Octet 2 - Bit 7)
> >          Read Clock Offset (Octet 3 - Bit 0)
> >          Read LMP Handle (Octet 3 - Bit 1)
> >          Sniff Mode (Octet 4 - Bit 2)
> >          Exit Sniff Mode (Octet 4 - Bit 3)
> >          QoS Setup (Octet 4 - Bit 6)
> >          Role Discovery (Octet 4 - Bit 7)
> >          Switch Role (Octet 5 - Bit 0)
> >          Read Link Policy Settings (Octet 5 - Bit 1)
> >          Write Link Policy Settings (Octet 5 - Bit 2)
> >          Read Default Link Policy Settings (Octet 5 - Bit 3)
> >          Write Default Link Policy Settings (Octet 5 - Bit 4)
> >          Flow Specification (Octet 5 - Bit 5)
> >          Set Event Mask (Octet 5 - Bit 6)
> >          Reset (Octet 5 - Bit 7)
> >          Set Event Filter (Octet 6 - Bit 0)
> >          Flush (Octet 6 - Bit 1)
> >          Read PIN Type (Octet 6 - Bit 2)
> >          Write PIN Type (Octet 6 - Bit 3)
> >          Create New Unit Key (Octet 6 - Bit 4)
> >          Read Stored Link Key (Octet 6 - Bit 5)
> >          Write Stored Link Key (Octet 6 - Bit 6)
> >          Delete Stored Link Key (Octet 6 - Bit 7)
> >          Write Local Name (Octet 7 - Bit 0)
> >          Read Local Name (Octet 7 - Bit 1)
> >          Read Connection Accept Timeout (Octet 7 - Bit 2)
> >          Write Connection Accept Timeout (Octet 7 - Bit 3)
> >          Read Page Timeout (Octet 7 - Bit 4)
> >          Write Page Timeout (Octet 7 - Bit 5)
> >          Read Scan Enable (Octet 7 - Bit 6)
> >          Write Scan Enable (Octet 7 - Bit 7)
> >          Read Page Scan Activity (Octet 8 - Bit 0)
> >          Write Page Scan Activity (Octet 8 - Bit 1)
> >          Read Inquiry Scan Activity (Octet 8 - Bit 2)
> >          Write Inquiry Scan Activity (Octet 8 - Bit 3)
> >          Read Authentication Enable (Octet 8 - Bit 4)
> >          Write Authentication Enable (Octet 8 - Bit 5)
> >          Read Encryption Mode (Octet 8 - Bit 6)
> >          Write Encryption Mode (Octet 8 - Bit 7)
> >          Read Class of Device (Octet 9 - Bit 0)
> >          Write Class of Device (Octet 9 - Bit 1)
> >          Read Voice Setting (Octet 9 - Bit 2)
> >          Write Voice Setting (Octet 9 - Bit 3)
> >          Read Automatic Flush Timeout (Octet 9 - Bit 4)
> >          Write Automatic Flush Timeout (Octet 9 - Bit 5)
> >          Read Num Broadcast Retransmissions (Octet 9 - Bit 6)
> >          Write Num Broadcast Retransmissions (Octet 9 - Bit 7)
> >          Read Transmit Power Level (Octet 10 - Bit 2)
> >          Read Sync Flow Control Enable (Octet 10 - Bit 3)
> >          Write Sync Flow Control Enable (Octet 10 - Bit 4)
> >          Set Controller To Host Flow Control (Octet 10 - Bit 5)
> >          Host Buffer Size (Octet 10 - Bit 6)
> >          Host Number of Completed Packets (Octet 10 - Bit 7)
> >          Read Link Supervision Timeout (Octet 11 - Bit 0)
> >          Write Link Supervision Timeout (Octet 11 - Bit 1)
> >          Read Number of Supported IAC (Octet 11 - Bit 2)
> >          Read Current IAC LAP (Octet 11 - Bit 3)
> >          Write Current IAC LAP (Octet 11 - Bit 4)
> >          Read Page Scan Mode (Octet 11 - Bit 7)
> >          Write Page Scan Mode (Octet 12 - Bit 0)
> >          Set AFH Host Channel Classification (Octet 12 - Bit 1)
> >          Read Inquiry Scan Type (Octet 12 - Bit 4)
> >          Write Inquiry Scan Type (Octet 12 - Bit 5)
> >          Read Inquiry Mode (Octet 12 - Bit 6)
> >          Write Inquiry Mode (Octet 12 - Bit 7)
> >          Read Page Scan Type (Octet 13 - Bit 0)
> >          Write Page Scan Type (Octet 13 - Bit 1)
> >          Read AFH Channel Assessment Mode (Octet 13 - Bit 2)
> >          Write AFH Channel Assessment Mode (Octet 13 - Bit 3)
> >          Read Local Version Information (Octet 14 - Bit 3)
> >          Read Local Supported Features (Octet 14 - Bit 5)
> >          Read Local Extended Features (Octet 14 - Bit 6)
> >          Read Buffer Size (Octet 14 - Bit 7)
> >          Read Country Code (Octet 15 - Bit 0)
> >          Read BD ADDR (Octet 15 - Bit 1)
> >          Read Failed Contact Counter (Octet 15 - Bit 2)
> >          Reset Failed Contact Counter (Octet 15 - Bit 3)
> >          Read Link Quality (Octet 15 - Bit 4)
> >          Read RSSI (Octet 15 - Bit 5)
> >          Read AFH Channel Map (Octet 15 - Bit 6)
> >          Read Clock (Octet 15 - Bit 7)
> >          Read Loopback Mode (Octet 16 - Bit 0)
> >          Write Loopback Mode (Octet 16 - Bit 1)
> >          Enable Device Under Test Mode (Octet 16 - Bit 2)
> >          Setup Synchronous Connection (Octet 16 - Bit 3)
> >          Accept Synchronous Connection Request (Octet 16 - Bit 4)
> >          Reject Synchronous Connection Request (Octet 16 - Bit 5)
> >          Read Extended Inquiry Response (Octet 17 - Bit 0)
> >          Write Extended Inquiry Response (Octet 17 - Bit 1)
> >          Refresh Encryption Key (Octet 17 - Bit 2)
> >          Sniff Subrating (Octet 17 - Bit 4)
> >          Read Simple Pairing Mode (Octet 17 - Bit 5)
> >          Write Simple Pairing Mode (Octet 17 - Bit 6)
> >          Read Local OOB Data (Octet 17 - Bit 7)
> >          Read Inquiry Response TX Power Level (Octet 18 - Bit 0)
> >          Write Inquiry Transmit Power Level (Octet 18 - Bit 1)
> >          Read Default Erroneous Data Reporting (Octet 18 - Bit 2)
> >          Write Default Erroneous Data Reporting (Octet 18 - Bit 3)
> >          IO Capability Request Reply (Octet 18 - Bit 7)
> >          User Confirmation Request Reply (Octet 19 - Bit 0)
> >          User Confirmation Request Neg Reply (Octet 19 - Bit 1)
> >          User Passkey Request Reply (Octet 19 - Bit 2)
> >          User Passkey Request Negative Reply (Octet 19 - Bit 3)
> >          Remote OOB Data Request Reply (Octet 19 - Bit 4)
> >          Write Simple Pairing Debug Mode (Octet 19 - Bit 5)
> >          Enhanced Flush (Octet 19 - Bit 6)
> >          Remote OOB Data Request Neg Reply (Octet 19 - Bit 7)
> >          Send Keypress Notification (Octet 20 - Bit 2)
> >          IO Capability Request Negative Reply (Octet 20 - Bit 3)
> >          Read Encryption Key Size (Octet 20 - Bit 4)
> >          Set Event Mask Page 2 (Octet 22 - Bit 2)
> >          Read Enhanced Transmit Power Level (Octet 24 - Bit 0)
> >          Enhanced Setup Synchronous Connection (Octet 29 - Bit 3)
> >          Enhanced Accept Synchronous Connection Request (Octet 29 - Bit 4)
> >          Read Local Supported Codecs (Octet 29 - Bit 5)
> >          Set Triggered Clock Capture (Octet 30 - Bit 5)
> >          Truncated Page (Octet 30 - Bit 6)
> >          Truncated Page Cancel (Octet 30 - Bit 7)
> >          Set Connectionless Slave Broadcast (Octet 31 - Bit 0)
> >          Start Synchronization Train (Octet 31 - Bit 2)
> >          Set Reserved LT_ADDR (Octet 31 - Bit 4)
> >          Delete Reserved LT_ADDR (Octet 31 - Bit 5)
> >          Set Connectionless Slave Broadcast Data (Octet 31 - Bit 6)
> >          Read Synchronization Train Parameters (Octet 31 - Bit 7)
> >          Write Synchronization Train Parameters (Octet 32 - Bit 0)
> >          Remote OOB Extended Data Request Reply (Octet 32 - Bit 1)
> >          Read Authenticated Payload Timeout (Octet 32 - Bit 4)
> >          Write Authenticated Payload Timeout (Octet 32 - Bit 5)
> >          Read Local OOB Extended Data (Octet 32 - Bit 6)
> >          Write Secure Connections Test Mode (Octet 32 - Bit 7)
> >          Read Extended Page Timeout (Octet 33 - Bit 0)
> >          Write Extended Page Timeout (Octet 33 - Bit 1)
> >          Read Extended Inquiry Length (Octet 33 - Bit 2)
> >          Write Extended Inquiry Length (Octet 33 - Bit 3)
> >          LE Set Data Length (Octet 33 - Bit 6)
> >          LE Read Suggested Default Data Length (Octet 33 - Bit 7)
> >          LE Write Suggested Default Data Length (Octet 34 - Bit 0)
> >          LE Read Local P-256 Public Key (Octet 34 - Bit 1)
> >          LE Generate DHKey (Octet 34 - Bit 2)
> >          LE Add Device To Resolving List (Octet 34 - Bit 3)
> >          LE Remove Device From Resolving List (Octet 34 - Bit 4)
> >          LE Clear Resolving List (Octet 34 - Bit 5)
> >          LE Read Resolving List Size (Octet 34 - Bit 6)
> >          LE Read Peer Resolvable Address (Octet 34 - Bit 7)
> >          LE Read Local Resolvable Address (Octet 35 - Bit 0)
> >          LE Set Address Resolution Enable (Octet 35 - Bit 1)
> >          LE Set Resolvable Private Address Timeout (Octet 35 - Bit 2)
> >          LE Read Maximum Data Length (Octet 35 - Bit 3)
> >          Octet 35 - Bit 4 
> >          Octet 35 - Bit 5 
> >          Octet 35 - Bit 6 
> >          Octet 35 - Bit 7 
> >          Octet 36 - Bit 0 
> 
> So you support the PHY commands, but do not indicate support LE 2M or LE Coded? Also these are Bluetooth 5.0 commands.
> 

To be honest. When I ported the device into Bluez core, a unexpected event for LE read local feature would cause a fail at Bluez core, so I made a hack on Bluez core  

to allow that I can keeping bring up the device without be blocked by the issue most probably from firmware.

Below code snippet is the only thing I added to avoid a fail at Bluez core to bring up the device.

@@ -927,6 +927,8 @@ static void hci_cc_le_read_local_features(struct hci_dev *hdev,
                return;

        memcpy(hdev->le_features, rp->features, 8);
+       hdev->le_features[0] = 0;
+       hdev->le_features[1] = 0;
 }


> > < HCI Command: Write Simple Pairing Mode (0x03|0x0056) plen 1  [hci0] 10.869023
> >        Mode: Enabled (0x01)
> >> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 10.869185
> >      Write Simple Pairing Mode (0x03|0x0056) ncmd 1
> >        Status: Success (0x00)
> > < HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1         [hci0] 10.869239
> >        Mode: Inquiry Result with RSSI or Extended Inquiry Result (0x02)
> >> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 10.869371
> >      Write Inquiry Mode (0x03|0x0045) ncmd 1
> >        Status: Success (0x00)
> > < HCI Command: Read Inquiry Response T.. (0x03|0x0058) plen 0  [hci0] 10.869396
> >> HCI Event: Command Complete (0x0e) plen 5                    [hci0] 10.869552
> >      Read Inquiry Response TX Power Level (0x03|0x0058) ncmd 1
> >        Status: Success (0x00)
> >        TX power: -1 dBm
> > < HCI Command: Read Local Extended Fea.. (0x04|0x0004) plen 1  [hci0] 10.869572
> >        Page: 1
> >> HCI Event: Command Complete (0x0e) plen 14                   [hci0] 10.869729
> >      Read Local Extended Features (0x04|0x0004) ncmd 1
> >        Status: Success (0x00)
> >        Page: 1/2
> >        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> >          Secure Simple Pairing (Host Support)
> > < HCI Command: Set Event Mask (0x03|0x0001) plen 8             [hci0] 10.869783
> >        Mask: 0x3dbff807fffbffff
> >          Inquiry Complete
> >          Inquiry Result
> >          Connection Complete
> >          Connection Request
> >          Disconnection Complete
> >          Authentication Complete
> >          Remote Name Request Complete
> >          Encryption Change
> >          Change Connection Link Key Complete
> >          Master Link Key Complete
> >          Read Remote Supported Features Complete
> >          Read Remote Version Information Complete
> >          QoS Setup Complete
> >          Command Complete
> >          Command Status
> >          Hardware Error
> >          Flush Occurred
> >          Role Change
> >          Mode Change
> >          Return Link Keys
> >          PIN Code Request
> >          Link Key Request
> >          Link Key Notification
> >          Loopback Command
> >          Data Buffer Overflow
> >          Max Slots Change
> >          Read Clock Offset Complete
> >          Connection Packet Type Changed
> >          QoS Violation
> >          Page Scan Mode Change
> >          Page Scan Repetition Mode Change
> >          Flow Specification Complete
> >          Inquiry Result with RSSI
> >          Read Remote Extended Features Complete
> >          Synchronous Connection Complete
> >          Synchronous Connection Changed
> >          Sniff Subrating
> >          Extended Inquiry Result
> >          Encryption Key Refresh Complete
> >          IO Capability Request
> >          IO Capability Request Reply
> >          User Confirmation Request
> >          User Passkey Request
> >          Remote OOB Data Request
> >          Simple Pairing Complete
> >          Link Supervision Timeout Changed
> >          Enhanced Flush Complete
> >          User Passkey Notification
> >          Keypress Notification
> >          Remote Host Supported Features Notification
> >          LE Meta
> >> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 10.869921
> >      Set Event Mask (0x03|0x0001) ncmd 1
> >        Status: Success (0x00)
> > < HCI Command: Read Stored Link Key (0x03|0x000d) plen 7       [hci0] 10.869947
> >        Address: 00:00:00:00:00:00 (OUI 00-00-00)
> >        Read all: 0x01
> >> HCI Event: Command Complete (0x0e) plen 8                    [hci0] 10.870129
> >      Read Stored Link Key (0x03|0x000d) ncmd 1
> >        Status: Success (0x00)
> >        Max num keys: 4
> >        Num keys: 0
> > < HCI Command: Write Default Link Poli.. (0x02|0x000f) plen 2  [hci0] 10.870148
> >        Link policy: 0x0005
> >          Enable Role Switch
> >          Enable Sniff Mode
> >> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 10.870310
> >      Write Default Link Policy Settings (0x02|0x000f) ncmd 1
> >        Status: Success (0x00)
> > < HCI Command: Read Page Scan Activity (0x03|0x001b) plen 0    [hci0] 10.870331
> >> HCI Event: Command Complete (0x0e) plen 8                    [hci0] 10.870485
> >      Read Page Scan Activity (0x03|0x001b) ncmd 1
> >        Status: Success (0x00)
> >        Interval: 1280.000 msec (0x0800)
> >        Window: 11.250 msec (0x0012)
> > < HCI Command: Read Page Scan Type (0x03|0x0046) plen 0        [hci0] 10.870504
> >> HCI Event: Command Complete (0x0e) plen 5                    [hci0] 10.870652
> >      Read Page Scan Type (0x03|0x0046) ncmd 1
> >        Status: Success (0x00)
> >        Type: Standard Scan (0x00)
> > < HCI Command: LE Set Event Mask (0x08|0x0001) plen 8          [hci0] 10.870671
> >        Mask: 0x0000000000000980
> >          LE Read Local P-256 Public Key Complete
> >          LE Generate DHKey Complete
> >          Unknown mask (0x0000000000000800)
> >> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 10.870839
> >      LE Set Event Mask (0x08|0x0001) ncmd 1
> >        Status: Success (0x00)
> > < HCI Command: Write LE Host Supported (0x03|0x006d) plen 2    [hci0] 10.870859
> >        Supported: 0x01
> >        Simultaneous: 0x00
> >> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 10.871028
> >      Write LE Host Supported (0x03|0x006d) ncmd 1
> >        Status: Success (0x00)
> > < HCI Command: Read Local Extended Fea.. (0x04|0x0004) plen 1  [hci0] 10.871059
> >        Page: 2
> >> HCI Event: Command Complete (0x0e) plen 14                   [hci0] 10.871201
> >      Read Local Extended Features (0x04|0x0004) ncmd 1
> >        Status: Success (0x00)
> >        Page: 2/2
> >        Features: 0x25 0x0b 0x00 0x00 0x00 0x00 0x00 0x00
> >          Connectionless Slave Broadcast - Master
> >          Synchronization Train
> >          Generalized interlaced scan
> >          Secure Connections (Controller Support)
> >          Ping
> >          Train nudging
> > < HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7     [hci0] 10.871240
> >        Address: 00:00:00:00:00:00 (OUI 00-00-00)
> >        Delete all: 0x01
> >> HCI Event: Command Complete (0x0e) plen 6                    [hci0] 10.871384
> >      Delete Stored Link Key (0x03|0x0012) ncmd 1
> >        Status: Success (0x00)
> >        Num keys: 0
> > < HCI Command: Set Event Mask Page 2 (0x03|0x0063) plen 8      [hci0] 10.871403
> >        Mask: 0x0000000000b0c000
> >          Triggered Clock Capture
> >          Synchronization Train Complete
> >          Slave Page Response Timeout
> >          Connectionless Slave Broadcast Channel Map Change
> >          Authenticated Payload Timeout Expired
> >> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 10.871566
> >      Set Event Mask Page 2 (0x03|0x0063) ncmd 1
> >        Status: Success (0x00)
> > < HCI Command: Read Local Supported Co.. (0x04|0x000b) plen 0  [hci0] 10.871599
> >> HCI Event: Command Complete (0x0e) plen 8                    [hci0] 10.871750
> >      Read Local Supported Codecs (0x04|0x000b) ncmd 1
> >        Status: Success (0x00)
> >        Number of supported codecs: 2
> >          Codec: CVSD (0x02)
> >          Codec: Transparent (0x03)
> >        Number of vendor codecs: 0
> > < HCI Command: Read Synchronization Tr.. (0x03|0x0077) plen 0  [hci0] 10.871769
> >> HCI Event: Command Complete (0x0e) plen 11                   [hci0] 10.871928
> >      Read Synchronization Train Parameters (0x03|0x0077) ncmd 1
> >        Status: Success (0x00)
> >        Interval: 0.000 msec (0x0000)
> >        Timeout: 0.000 msec (0x00000000)
> >        Service data: 0x00
> > < HCI Command: Write Secure Connection.. (0x03|0x007a) plen 1  [hci0] 10.871947
> >        Support: Enabled (0x01)
> >> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 10.872098
> >      Write Secure Connections Host Support (0x03|0x007a) ncmd 1
> >        Status: Success (0x00)
> > < HCI Command: Unknown (0x08|0x0031) plen 3                    [hci0] 10.872156
> >        03 00 00                                         ...             
> >> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 10.872322
> >      Unknown (0x08|0x0031) ncmd 1
> >        Status: Success (0x00)
> > = Index Info: 00:00:46:76:22:01 (MediaTek, Inc.)               [hci0] 10.872361
> 
> This extra index info worries me a little bit. I need to check if that is suppose to happen.
> > < HCI Command: LE Set Scan Response D.. (0x08|0x0009) plen 32  [hci0] 10.872431
> >        Length: 10
> >        Name (complete): builder
> >> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 10.872606
> >      LE Set Scan Response Data (0x08|0x0009) ncmd 1
> >        Status: Success (0x00)
> > < HCI Command: Write Scan Enable (0x03|0x001a) plen 1          [hci0] 10.872627
> >        Scan enable: Page Scan (0x02)
> >> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 10.872819
> >      Write Scan Enable (0x03|0x001a) ncmd 1
> >        Status: Success (0x00)
> > < HCI Command: Write Class of Device (0x03|0x0024) plen 3      [hci0] 10.872841
> >        Class: 0x000000
> >          Major class: Miscellaneous
> >          Minor class: 0x00
> >> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 10.873036
> >      Write Class of Device (0x03|0x0024) ncmd 1
> >        Status: Success (0x00)
> > * Unknown packet (code 17 len 9)                               [hci0] 10.873069
> >        02 00 00 00 07 00 00 00 00                       .........       
> > * Unknown packet (code 17 len 9)                               [hci0] 10.873069
> >        01 00 00 00 07 00 00 00 00                       .........       
> > < HCI Command: Write Local Name (0x03|0x0013) plen 248         [hci0] 10.873096
> >        Name: builder
> >> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 10.873446
> >      Write Local Name (0x03|0x0013) ncmd 1
> >        Status: Success (0x00)
> > < HCI Command: Write Extended Inquir.. (0x03|0x0052) plen 241  [hci0] 10.873470
> >        FEC: Not required (0x00)
> >        Name (complete): builder
> >        TX power: -1 dBm
> >        Device ID: USB Implementer's Forum assigned (0x0002)
> >          Vendor: Linux Foundation (0x1d6b)
> >          Product: 0x0246
> >          Version: 5.2.11 (0x052b)
> >        16-bit Service UUIDs (complete): 4 entries
> >          Generic Access Profile (0x1800)
> >          Generic Attribute Profile (0x1801)
> >          A/V Remote Control (0x110e)
> >          A/V Remote Control Target (0x110c)
> >> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 10.873857
> >      Write Extended Inquiry Response (0x03|0x0052) ncmd 1
> >        Status: Success (0x00)
> > * Unknown packet (code 17 len 13)                              [hci0] 10.873903
> >        01 00 00 00 01 00 05 00 00 d1 0a 00 00           .............   
> > * Unknown packet (code 17 len 10)                              [hci0] 10.873913
> >        02 00 00 00 06 00 d1 0a 00 00                    ..........      
> > * Unknown packet (code 16 len 7)                               [hci0] 17.803939
> >        01 00 00 00 05 00 00                             .......         
> > < HCI Command: Write Scan Enable (0x03|0x001a) plen 1          [hci0] 17.803983
> >        Scan enable: No Scans (0x00)
> >> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 17.804233
> >      Write Scan Enable (0x03|0x001a) ncmd 1
> >        Status: Success (0x00)
> > < HCI Command: Vendor (0x3f|0x006f) plen 6                     [hci0] 17.804282
> >        01 06 02 00 00 00                                ......          
> >> HCI Event: Unknown (0xe4) plen 5                             [hci0] 17.804636
> >        02 06 01 00 00                                   .....           
> > * Unknown packet (code 17 len 13)                              [hci0] 17.811580
> >        01 00 00 00 01 00 05 00 00 d0 0a 00 00           .............   
> > * Unknown packet (code 17 len 10)                              [hci0] 17.811596
> >        02 00 00 00 06 00 d0 0a 00 00                    ..........      
> > = Close Index: 00:00:46:76:22:01                               [hci0] 17.811625
> 
> Regards
> 
> Marcel
> 
