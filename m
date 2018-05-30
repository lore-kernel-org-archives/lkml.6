Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937030AbeE3G0s convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 02:26:48 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46643 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935423AbeE3G0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 02:26:45 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v2 4/7] Bluetooth: Add new quirk for non-persistent setup
 settings
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1527175805.4607.103.camel@mtkswgap22>
Date: Wed, 30 May 2018 08:26:42 +0200
Cc: Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <DC3FE66E-C3FD-455F-8592-E927604086CD@holtmann.org>
References: <cover.1526374087.git.sean.wang@mediatek.com>
 <1d6097f538b3182b2876ad48225ecd6e2d1b128c.1526374087.git.sean.wang@mediatek.com>
 <920B3BE9-3FE8-4AC6-8C5F-63B0E00182AC@holtmann.org>
 <1526976323.18877.47.camel@mtkswgap22> <1527057423.4607.3.camel@mtkswgap22>
 <B82BB5F4-E197-4915-A543-C5FF9A5A41F1@holtmann.org>
 <1527084544.4607.8.camel@mtkswgap22>
 <37400FCE-8F9A-433B-8E3A-DE9CBEB469D7@holtmann.org>
 <1527175805.4607.103.camel@mtkswgap22>
To: Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

>>>>>> 
>>>>>> [ ... ]
> 
> [ ... ]
> 
>>> I post it as plain text as below 
>>> 
>>> 
>>> Bluetooth monitor ver 5.37
>>> = Note: Linux version 4.16.0-rc1+ (aarch64)                            0.641494
>>> = Note: Bluetooth subsystem version 2.22                               0.641502
>>> = New Index: 00:00:46:76:22:01 (BR/EDR,UART,hci0)               [hci0] 0.641505
>>> * Unknown packet (code 14 len 30)                                      0.641509
>>>       01 00 00 00 02 00 01 0e 00 01 00 00 00 10 62 6c  ..............bl
>>>       75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
>>> * Unknown packet (code 14 len 30)                                      0.641592
>>>       02 00 00 00 02 00 01 0e 00 01 00 00 00 10 62 74  ..............bt
>>>       6d 6f 6e 00 00 00 00 00 00 00 00 00 00 00        mon...........  
>>> * Unknown packet (code 16 len 7)                                [hci0] 6.536771
>>>       01 00 00 00 05 00 01                             .......         
>>> = Open Index: 00:00:46:76:22:01                                 [hci0] 6.717019
>>> = Index Info: 00:00:46:76:22:01 (MediaTek, Inc.)                [hci0] 6.717030
>> 
>> can you try with the latest BlueZ 5.49 or git version. Seems it actually stumbles over the extra packet here. Fun fact is that I can not get a backtrace to pin-point the issue in btmon and why it crashes.
>> 
> 
> I had less experience updating user land BlueZ, but I can try it as possible and see whether Unknown packets still are present at newest version BlueZ. Hopefully I don't misunderstand your point here. 

please use the latest btmon and check if it can read your trace.

>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.741093
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.742088
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.743102
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.744105
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.745109
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.746104
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.747097
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.748090
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.749078
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.750070
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.751061
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.752054
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.753046
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.754038
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.755031
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.756025
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.757013
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.758006
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.758999
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.759991
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.760983
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.761975
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.762963
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.763956
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.764948
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.765941
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.766933
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.767926
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.768919
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.769914
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.770909
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.771908
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.772904
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.773898
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.774892
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.775890
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.776882
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.777877
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.778871
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.779869
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.780864
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.781858
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.782852
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.783850
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.784845
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.785839
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.786833
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.787831
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.788826
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.789820
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.790814
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.791813
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.792809
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.793803
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.794798
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.795797
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.796791
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.797786
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.798779
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.799778
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.800774
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.801769
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.802763
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.803761
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.804755
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.805749
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.806743
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.807741
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.808737
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.809731
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.810725
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.811725
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.812719
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.813714
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.814708
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.815705
>>>       02 01 01 00 00                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.816378
>>>       02 01 01 00 00                                   .....           
>> 
>> Why do I see only HCI events here? Is this event conveying any useful information. It is kinda complicated that this is 0xe4 event code which is actually reserved for future use by the Bluetooth SIG. Are there any accompanying HCI commands for this and they just not make it into btmon?
>> 
> 
> I have made all vendor HCI commands go through BlueZ core in v2 patch. 
> 
> And for these HCI events, they are all corresponding to vendor ACL data, applied only to firmware setup packets, but they're not being sent via BlueZ core, so they are not being logged in btmon.
> 
> As for its event, where heading 0xe4 refers to a vendor event and is used on notification of that either vendor ACL data or vendor HCI command have been done.

I would prefer if everything goes via the Bluetooth core since then we have it all properly scheduled. Sending things down the ACL data path however if kinda funky. Does your hardware accept sending command both via ACL data and as HCI command? If so, then I would prefer sending them as HCI commands since the speed improvement you think you are getting is neglectable on Linux (I have been down that path). This seems to be a pure optimization when Windows is driving the device.

And the vendor event 0xe4 is really only received during firmware download? It is not ever received during normal operation?

> 
>> 
>> 
>>> < HCI Command: Vendor (0x3f|0x006f) plen 5                      [hci0] 6.816413
>>>       01 07 01 00 04                                   .....           
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.816536
>>>       02 07 01 00 00                                   .....           
>>> < HCI Command: Vendor (0x3f|0x006f) plen 6                      [hci0] 8.845071
>>>       01 06 02 00 00 01                                ......          
>>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 8.923456
>>>       02 06 01 00 00                                   .....           
>> 
>> Here it looks like you have 0x006f opcode with first octet 0x01 for command and then vendor event 0xe4 with first octet 0x02 for event. I assume the second octet is then the vendor command code for these.
>> 
> 
> Yes, you're right.
> 
>>> < HCI Command: Reset (0x03|0x0003) plen 0                      [hci0] 10.861118
>>>> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 10.865763
>>>     Reset (0x03|0x0003) ncmd 1
>>>       Status: Success (0x00)
>>> < HCI Command: Read Local Supported Fe.. (0x04|0x0003) plen 0  [hci0] 10.865805
>>>> HCI Event: Command Complete (0x0e) plen 12                   [hci0] 10.865965
>>>     Read Local Supported Features (0x04|0x0003) ncmd 1
>>>       Status: Success (0x00)
>>>       Features: 0xbf 0x3e 0x8d 0xfe 0xdb 0xff 0x7b 0x87
>>>         3 slot packets
>>>         5 slot packets
>>>         Encryption
>>>         Slot offset
>>>         Timing accuracy
>>>         Role switch
>>>         Sniff mode
>>>         Power control requests
>>>         Channel quality driven data rate (CQDDR)
>>>         SCO link
>>>         HV2 packets
>>>         HV3 packets
>>>         CVSD synchronous data
>>>         Power control
>>>         Transparent synchronous data
>>>         Broadcast Encryption
>>>         Enhanced Data Rate ACL 2 Mbps mode
>>>         Enhanced Data Rate ACL 3 Mbps mode
>>>         Enhanced inquiry scan
>>>         Interlaced inquiry scan
>>>         Interlaced page scan
>>>         RSSI with inquiry results
>>>         Extended SCO link (EV3 packets)
>>>         EV4 packets
>>>         EV5 packets
>>>         AFH capable slave
>>>         AFH classification slave
>>>         LE Supported (Controller)
>>>         3-slot Enhanced Data Rate ACL packets
>>>         5-slot Enhanced Data Rate ACL packets
>>>         Sniff subrating
>>>         Pause encryption
>>>         AFH capable master
>>>         AFH classification master
>>>         Enhanced Data Rate eSCO 2 Mbps mode
>>>         Enhanced Data Rate eSCO 3 Mbps mode
>>>         3-slot Enhanced Data Rate eSCO packets
>>>         Extended Inquiry Response
>>>         Simultaneous LE and BR/EDR (Controller)
>>>         Secure Simple Pairing
>>>         Encapsulated PDU
>>>         Erroneous Data Reporting
>>>         Non-flushable Packet Boundary Flag
>>>         Link Supervision Timeout Changed Event
>>>         Inquiry TX Power Level
>>>         Enhanced Power Control
>>>         Extended features
>>> < HCI Command: Read Local Version Info.. (0x04|0x0001) plen 0  [hci0] 10.865987
>>>> HCI Event: Vendor (0xff) plen 9                              [hci0] 10.866259
>>>       29 19 09 17 20 48 07 11 00                       )... H…       
>> 
>> Is this meant to happen here?
>> 
> 
> If event received is not expected as the specification defines, I think it's probably incorrect.
> 
> But it requires more discussion with firmware people to make it clearer.

Please check and let them decode what this event means.

> 
>>>> HCI Event: Command Complete (0x0e) plen 12                   [hci0] 10.866372
>>>     Read Local Version Information (0x04|0x0001) ncmd 1
>>>       Status: Success (0x00)
>>>       HCI version: Bluetooth 4.2 (0x08) - Revision 4359 (0x1107)
>>>       LMP version: Bluetooth 4.2 (0x08) - Subversion 2329 (0x0919)
>>>       Manufacturer: MediaTek, Inc. (70)
>>> < HCI Command: Read BD ADDR (0x04|0x0009) plen 0               [hci0] 10.866391
>>>> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 10.866539
>>>     Read BD ADDR (0x04|0x0009) ncmd 1
>>>       Status: Success (0x00)
>>>       Address: 00:00:46:76:22:01 (OLIVETTI NORTH AMERICA)
>>> < HCI Command: Read Buffer Size (0x04|0x0005) plen 0           [hci0] 10.866609
>>>> HCI Event: Command Complete (0x0e) plen 11                   [hci0] 10.866754
>>>     Read Buffer Size (0x04|0x0005) ncmd 1
>>>       Status: Success (0x00)
>>>       ACL MTU: 1021 ACL max packet: 8
>>>       SCO MTU: 184  SCO max packet: 1
>>> < HCI Command: Read Class of Device (0x03|0x0023) plen 0       [hci0] 10.866775
>>>> HCI Event: Command Complete (0x0e) plen 7                    [hci0] 10.866920
>>>     Read Class of Device (0x03|0x0023) ncmd 1
>>>       Status: Success (0x00)
>>>       Class: 0x001f00
>>>         Major class: Uncategorized, specific device code not specified
>>>         Minor class: 0x00
>>> < HCI Command: Read Local Name (0x03|0x0014) plen 0            [hci0] 10.866939
>>>> HCI Event: Command Complete (0x0e) plen 252                  [hci0] 10.867256
>>>     Read Local Name (0x03|0x0014) ncmd 1
>>>       Status: Success (0x00)
>>>       Name: MTK MT7622 #1
>>> < HCI Command: Read Voice Setting (0x03|0x0025) plen 0         [hci0] 10.867308
>>>> HCI Event: Command Complete (0x0e) plen 6                    [hci0] 10.867447
>>>     Read Voice Setting (0x03|0x0025) ncmd 1
>>>       Status: Success (0x00)
>>>       Setting: 0x0060
>>>         Input Coding: Linear
>>>         Input Data Format: 2's complement
>>>         Input Sample Size: 16-bit
>>>         # of bits padding at MSB: 0
>>>         Air Coding Format: CVSD
>>> < HCI Command: Read Number of Supporte.. (0x03|0x0038) plen 0  [hci0] 10.867474
>>>> HCI Event: Command Complete (0x0e) plen 5                    [hci0] 10.867611
>>>     Read Number of Supported IAC (0x03|0x0038) ncmd 1
>>>       Status: Success (0x00)
>>>       Number of IAC: 4
>>> < HCI Command: Read Current IAC LAP (0x03|0x0039) plen 0       [hci0] 10.867678
>>>> HCI Event: Command Complete (0x0e) plen 8                    [hci0] 10.867865
>>>     Read Current IAC LAP (0x03|0x0039) ncmd 1
>>>       Status: Success (0x00)
>>>       Number of IAC: 1
>>>       Access code: 0x9e8b33 (General Inquiry)
>>> < HCI Command: Set Event Filter (0x03|0x0005) plen 1           [hci0] 10.867890
>>>       Type: Clear All Filters (0x00)
>>>> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 10.868033
>>>     Set Event Filter (0x03|0x0005) ncmd 1
>>>       Status: Success (0x00)
>>> < HCI Command: Write Connection Accept.. (0x03|0x0016) plen 2  [hci0] 10.868054
>>>       Timeout: 20000.000 msec (0x7d00)
>>>> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 10.868235
>>>     Write Connection Accept Timeout (0x03|0x0016) ncmd 1
>>>       Status: Success (0x00)
>>> < HCI Command: LE Read Buffer Size (0x08|0x0002) plen 0        [hci0] 10.868262
>>>> HCI Event: Command Complete (0x0e) plen 7                    [hci0] 10.868392
>>>     LE Read Buffer Size (0x08|0x0002) ncmd 1
>>>       Status: Success (0x00)
>>>       Data packet length: 251
>>>       Num data packets: 8
>>> < HCI Command: LE Read Local Supported.. (0x08|0x0003) plen 0  [hci0] 10.868413
>>>> HCI Event: Command Complete (0x0e) plen 12                   [hci0] 10.868587
>>>     LE Read Local Supported Features (0x08|0x0003) ncmd 1
>>>       Status: Success (0x00)
>>>       Features: 0xfd 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>>>         LE Encryption
>>>         Extended Reject Indication
>>>         Slave-initiated Features Exchange
>>>         LE Ping
>>>         LE Data Packet Length Extension
>>>         LL Privacy
>>>         Extended Scanner Filter Policies
>>> < HCI Command: LE Read Supported States (0x08|0x001c) plen 0   [hci0] 10.868646
>>>> HCI Event: Command Complete (0x0e) plen 12                   [hci0] 10.868787
>>>     LE Read Supported States (0x08|0x001c) ncmd 1
>>>       Status: Success (0x00)
>>>       States: 0x000000001fffffff
>>>         Non-connectable Advertising State
>>>         Scannable Advertising State
>>>         Connectable Advertising State
>>>         High Duty Cycle Directed Advertising State
>>>         Passive Scanning State
>>>         Active Scanning State
>>>         Initiating State
>>>           and Connection State (Master Role)
>>>         Connection State (Slave Role)
>>>         Non-connectable Advertising State
>>>           and Passive Scanning State
>>>         Scannable Advertising State
>>>           and Passive Scanning State
>>>         Connectable Advertising State
>>>           and Passive Scanning State
>>>         High Duty Cycle Directed Advertising State
>>>           and Passive Scanning State
>>>         Non-connectable Advertising State
>>>           and Active Scanning State
>>>         Scannable Advertising State
>>>           and Active Scanning State
>>>         Connectable Advertising State
>>>           and Active Scanning State
>>>         High Duty Cycle Directed Advertising State
>>>           and Active Scanning State
>>>         Non-connectable Advertising State
>>>           and Initiating State
>>>         Scannable Advertising State
>>>           and Initiating State
>>>         Non-connectable Advertising State
>>>           and Connection State (Master Role)
>>>         Scannable Advertising State
>>>           and Connection State (Master Role)
>>>         Non-connectable Advertising State
>>>           and Connection State (Slave Role)
>>>         Scannable Advertising State
>>>           and Connection State (Slave Role)
>>>         Passive Scanning State
>>>           and Initiating State
>>>         Active Scanning State
>>>           and Initiating State
>>>         Passive Scanning State
>>>           and Connection State (Master Role)
>>>         Active Scanning State
>>>           and Connection State (Master Role)
>>>         Passive Scanning State
>>>           and Connection State (Slave Role)
>>>         Active Scanning State
>>>           and Connection State (Slave Role)
>>>         Initiating State
>>>           and Connection State (Master Role)
>>>           and Master Role & Master Role
>>> < HCI Command: Read Local Supported Co.. (0x04|0x0002) plen 0  [hci0] 10.868807
>>>> HCI Event: Command Complete (0x0e) plen 68                   [hci0] 10.868985
>>>     Read Local Supported Commands (0x04|0x0002) ncmd 1
>>>       Status: Success (0x00)
>>>       Commands: 176 entries
>>>         Inquiry (Octet 0 - Bit 0)
>>>         Inquiry Cancel (Octet 0 - Bit 1)
>>>         Periodic Inquiry Mode (Octet 0 - Bit 2)
>>>         Exit Periodic Inquiry Mode (Octet 0 - Bit 3)
>>>         Create Connection (Octet 0 - Bit 4)
>>>         Disconnect (Octet 0 - Bit 5)
>>>         Add SCO Connection (Octet 0 - Bit 6)
>>>         Create Connection Cancel (Octet 0 - Bit 7)
>>>         Accept Connection Request (Octet 1 - Bit 0)
>>>         Reject Connection Request (Octet 1 - Bit 1)
>>>         Link Key Request Reply (Octet 1 - Bit 2)
>>>         Link Key Request Negative Reply (Octet 1 - Bit 3)
>>>         PIN Code Request Reply (Octet 1 - Bit 4)
>>>         PIN Code Request Negative Reply (Octet 1 - Bit 5)
>>>         Change Connection Packet Type (Octet 1 - Bit 6)
>>>         Authentication Requested (Octet 1 - Bit 7)
>>>         Set Connection Encryption (Octet 2 - Bit 0)
>>>         Change Connection Link Key (Octet 2 - Bit 1)
>>>         Master Link Key (Octet 2 - Bit 2)
>>>         Remote Name Request (Octet 2 - Bit 3)
>>>         Remote Name Request Cancel (Octet 2 - Bit 4)
>>>         Read Remote Supported Features (Octet 2 - Bit 5)
>>>         Read Remote Extended Features (Octet 2 - Bit 6)
>>>         Read Remote Version Information (Octet 2 - Bit 7)
>>>         Read Clock Offset (Octet 3 - Bit 0)
>>>         Read LMP Handle (Octet 3 - Bit 1)
>>>         Sniff Mode (Octet 4 - Bit 2)
>>>         Exit Sniff Mode (Octet 4 - Bit 3)
>>>         QoS Setup (Octet 4 - Bit 6)
>>>         Role Discovery (Octet 4 - Bit 7)
>>>         Switch Role (Octet 5 - Bit 0)
>>>         Read Link Policy Settings (Octet 5 - Bit 1)
>>>         Write Link Policy Settings (Octet 5 - Bit 2)
>>>         Read Default Link Policy Settings (Octet 5 - Bit 3)
>>>         Write Default Link Policy Settings (Octet 5 - Bit 4)
>>>         Flow Specification (Octet 5 - Bit 5)
>>>         Set Event Mask (Octet 5 - Bit 6)
>>>         Reset (Octet 5 - Bit 7)
>>>         Set Event Filter (Octet 6 - Bit 0)
>>>         Flush (Octet 6 - Bit 1)
>>>         Read PIN Type (Octet 6 - Bit 2)
>>>         Write PIN Type (Octet 6 - Bit 3)
>>>         Create New Unit Key (Octet 6 - Bit 4)
>>>         Read Stored Link Key (Octet 6 - Bit 5)
>>>         Write Stored Link Key (Octet 6 - Bit 6)
>>>         Delete Stored Link Key (Octet 6 - Bit 7)
>>>         Write Local Name (Octet 7 - Bit 0)
>>>         Read Local Name (Octet 7 - Bit 1)
>>>         Read Connection Accept Timeout (Octet 7 - Bit 2)
>>>         Write Connection Accept Timeout (Octet 7 - Bit 3)
>>>         Read Page Timeout (Octet 7 - Bit 4)
>>>         Write Page Timeout (Octet 7 - Bit 5)
>>>         Read Scan Enable (Octet 7 - Bit 6)
>>>         Write Scan Enable (Octet 7 - Bit 7)
>>>         Read Page Scan Activity (Octet 8 - Bit 0)
>>>         Write Page Scan Activity (Octet 8 - Bit 1)
>>>         Read Inquiry Scan Activity (Octet 8 - Bit 2)
>>>         Write Inquiry Scan Activity (Octet 8 - Bit 3)
>>>         Read Authentication Enable (Octet 8 - Bit 4)
>>>         Write Authentication Enable (Octet 8 - Bit 5)
>>>         Read Encryption Mode (Octet 8 - Bit 6)
>>>         Write Encryption Mode (Octet 8 - Bit 7)
>>>         Read Class of Device (Octet 9 - Bit 0)
>>>         Write Class of Device (Octet 9 - Bit 1)
>>>         Read Voice Setting (Octet 9 - Bit 2)
>>>         Write Voice Setting (Octet 9 - Bit 3)
>>>         Read Automatic Flush Timeout (Octet 9 - Bit 4)
>>>         Write Automatic Flush Timeout (Octet 9 - Bit 5)
>>>         Read Num Broadcast Retransmissions (Octet 9 - Bit 6)
>>>         Write Num Broadcast Retransmissions (Octet 9 - Bit 7)
>>>         Read Transmit Power Level (Octet 10 - Bit 2)
>>>         Read Sync Flow Control Enable (Octet 10 - Bit 3)
>>>         Write Sync Flow Control Enable (Octet 10 - Bit 4)
>>>         Set Controller To Host Flow Control (Octet 10 - Bit 5)
>>>         Host Buffer Size (Octet 10 - Bit 6)
>>>         Host Number of Completed Packets (Octet 10 - Bit 7)
>>>         Read Link Supervision Timeout (Octet 11 - Bit 0)
>>>         Write Link Supervision Timeout (Octet 11 - Bit 1)
>>>         Read Number of Supported IAC (Octet 11 - Bit 2)
>>>         Read Current IAC LAP (Octet 11 - Bit 3)
>>>         Write Current IAC LAP (Octet 11 - Bit 4)
>>>         Read Page Scan Mode (Octet 11 - Bit 7)
>>>         Write Page Scan Mode (Octet 12 - Bit 0)
>>>         Set AFH Host Channel Classification (Octet 12 - Bit 1)
>>>         Read Inquiry Scan Type (Octet 12 - Bit 4)
>>>         Write Inquiry Scan Type (Octet 12 - Bit 5)
>>>         Read Inquiry Mode (Octet 12 - Bit 6)
>>>         Write Inquiry Mode (Octet 12 - Bit 7)
>>>         Read Page Scan Type (Octet 13 - Bit 0)
>>>         Write Page Scan Type (Octet 13 - Bit 1)
>>>         Read AFH Channel Assessment Mode (Octet 13 - Bit 2)
>>>         Write AFH Channel Assessment Mode (Octet 13 - Bit 3)
>>>         Read Local Version Information (Octet 14 - Bit 3)
>>>         Read Local Supported Features (Octet 14 - Bit 5)
>>>         Read Local Extended Features (Octet 14 - Bit 6)
>>>         Read Buffer Size (Octet 14 - Bit 7)
>>>         Read Country Code (Octet 15 - Bit 0)
>>>         Read BD ADDR (Octet 15 - Bit 1)
>>>         Read Failed Contact Counter (Octet 15 - Bit 2)
>>>         Reset Failed Contact Counter (Octet 15 - Bit 3)
>>>         Read Link Quality (Octet 15 - Bit 4)
>>>         Read RSSI (Octet 15 - Bit 5)
>>>         Read AFH Channel Map (Octet 15 - Bit 6)
>>>         Read Clock (Octet 15 - Bit 7)
>>>         Read Loopback Mode (Octet 16 - Bit 0)
>>>         Write Loopback Mode (Octet 16 - Bit 1)
>>>         Enable Device Under Test Mode (Octet 16 - Bit 2)
>>>         Setup Synchronous Connection (Octet 16 - Bit 3)
>>>         Accept Synchronous Connection Request (Octet 16 - Bit 4)
>>>         Reject Synchronous Connection Request (Octet 16 - Bit 5)
>>>         Read Extended Inquiry Response (Octet 17 - Bit 0)
>>>         Write Extended Inquiry Response (Octet 17 - Bit 1)
>>>         Refresh Encryption Key (Octet 17 - Bit 2)
>>>         Sniff Subrating (Octet 17 - Bit 4)
>>>         Read Simple Pairing Mode (Octet 17 - Bit 5)
>>>         Write Simple Pairing Mode (Octet 17 - Bit 6)
>>>         Read Local OOB Data (Octet 17 - Bit 7)
>>>         Read Inquiry Response TX Power Level (Octet 18 - Bit 0)
>>>         Write Inquiry Transmit Power Level (Octet 18 - Bit 1)
>>>         Read Default Erroneous Data Reporting (Octet 18 - Bit 2)
>>>         Write Default Erroneous Data Reporting (Octet 18 - Bit 3)
>>>         IO Capability Request Reply (Octet 18 - Bit 7)
>>>         User Confirmation Request Reply (Octet 19 - Bit 0)
>>>         User Confirmation Request Neg Reply (Octet 19 - Bit 1)
>>>         User Passkey Request Reply (Octet 19 - Bit 2)
>>>         User Passkey Request Negative Reply (Octet 19 - Bit 3)
>>>         Remote OOB Data Request Reply (Octet 19 - Bit 4)
>>>         Write Simple Pairing Debug Mode (Octet 19 - Bit 5)
>>>         Enhanced Flush (Octet 19 - Bit 6)
>>>         Remote OOB Data Request Neg Reply (Octet 19 - Bit 7)
>>>         Send Keypress Notification (Octet 20 - Bit 2)
>>>         IO Capability Request Negative Reply (Octet 20 - Bit 3)
>>>         Read Encryption Key Size (Octet 20 - Bit 4)
>>>         Set Event Mask Page 2 (Octet 22 - Bit 2)
>>>         Read Enhanced Transmit Power Level (Octet 24 - Bit 0)
>>>         Enhanced Setup Synchronous Connection (Octet 29 - Bit 3)
>>>         Enhanced Accept Synchronous Connection Request (Octet 29 - Bit 4)
>>>         Read Local Supported Codecs (Octet 29 - Bit 5)
>>>         Set Triggered Clock Capture (Octet 30 - Bit 5)
>>>         Truncated Page (Octet 30 - Bit 6)
>>>         Truncated Page Cancel (Octet 30 - Bit 7)
>>>         Set Connectionless Slave Broadcast (Octet 31 - Bit 0)
>>>         Start Synchronization Train (Octet 31 - Bit 2)
>>>         Set Reserved LT_ADDR (Octet 31 - Bit 4)
>>>         Delete Reserved LT_ADDR (Octet 31 - Bit 5)
>>>         Set Connectionless Slave Broadcast Data (Octet 31 - Bit 6)
>>>         Read Synchronization Train Parameters (Octet 31 - Bit 7)
>>>         Write Synchronization Train Parameters (Octet 32 - Bit 0)
>>>         Remote OOB Extended Data Request Reply (Octet 32 - Bit 1)
>>>         Read Authenticated Payload Timeout (Octet 32 - Bit 4)
>>>         Write Authenticated Payload Timeout (Octet 32 - Bit 5)
>>>         Read Local OOB Extended Data (Octet 32 - Bit 6)
>>>         Write Secure Connections Test Mode (Octet 32 - Bit 7)
>>>         Read Extended Page Timeout (Octet 33 - Bit 0)
>>>         Write Extended Page Timeout (Octet 33 - Bit 1)
>>>         Read Extended Inquiry Length (Octet 33 - Bit 2)
>>>         Write Extended Inquiry Length (Octet 33 - Bit 3)
>>>         LE Set Data Length (Octet 33 - Bit 6)
>>>         LE Read Suggested Default Data Length (Octet 33 - Bit 7)
>>>         LE Write Suggested Default Data Length (Octet 34 - Bit 0)
>>>         LE Read Local P-256 Public Key (Octet 34 - Bit 1)
>>>         LE Generate DHKey (Octet 34 - Bit 2)
>>>         LE Add Device To Resolving List (Octet 34 - Bit 3)
>>>         LE Remove Device From Resolving List (Octet 34 - Bit 4)
>>>         LE Clear Resolving List (Octet 34 - Bit 5)
>>>         LE Read Resolving List Size (Octet 34 - Bit 6)
>>>         LE Read Peer Resolvable Address (Octet 34 - Bit 7)
>>>         LE Read Local Resolvable Address (Octet 35 - Bit 0)
>>>         LE Set Address Resolution Enable (Octet 35 - Bit 1)
>>>         LE Set Resolvable Private Address Timeout (Octet 35 - Bit 2)
>>>         LE Read Maximum Data Length (Octet 35 - Bit 3)
>>>         Octet 35 - Bit 4 
>>>         Octet 35 - Bit 5 
>>>         Octet 35 - Bit 6 
>>>         Octet 35 - Bit 7 
>>>         Octet 36 - Bit 0 
>> 
>> So you support the PHY commands, but do not indicate support LE 2M or LE Coded? Also these are Bluetooth 5.0 commands.
>> 
> 
> To be honest. When I ported the device into Bluez core, a unexpected event for LE read local feature would cause a fail at Bluez core, so I made a hack on Bluez core  
> 
> to allow that I can keeping bring up the device without be blocked by the issue most probably from firmware.
> 
> Below code snippet is the only thing I added to avoid a fail at Bluez core to bring up the device.
> 
> @@ -927,6 +927,8 @@ static void hci_cc_le_read_local_features(struct hci_dev *hdev,
>                return;
> 
>        memcpy(hdev->le_features, rp->features, 8);
> +       hdev->le_features[0] = 0;
> +       hdev->le_features[1] = 0;
> }

Send me the trace where you didn’t clear the feature bits and I check what is going on. I doubt that we have a bug, but maybe some of the commands are optional and we should add an appropriate check. Or you guys need to fix your firmware. A new btmon should decode all bits properly.

Regards

Marcel
