Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A6DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 20:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D031E21855
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 20:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfBQUzs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 15:55:48 -0500
Received: from mail-oln040092069010.outbound.protection.outlook.com ([40.92.69.10]:14336
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbfBQUzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 15:55:48 -0500
Received: from AM5EUR02FT021.eop-EUR02.prod.protection.outlook.com
 (10.152.8.51) by AM5EUR02HT118.eop-EUR02.prod.protection.outlook.com
 (10.152.9.115) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Sun, 17 Feb
 2019 20:55:42 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com (10.152.8.55) by
 AM5EUR02FT021.mail.protection.outlook.com (10.152.8.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Sun, 17 Feb 2019 20:55:42 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105]) by VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105%5]) with mapi id 15.20.1643.008; Sun, 17 Feb 2019
 20:55:42 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCHv4] random: Make /dev/random wait for input_pool initialized
Thread-Topic: [PATCHv4] random: Make /dev/random wait for input_pool
 initialized
Thread-Index: AQHUxwMldu7JSGDWkkyAZcNCWFdW+w==
Date:   Sun, 17 Feb 2019 20:55:42 +0000
Message-ID: <VI1PR0702MB3840F83AD88C7808C49E2AF8E4620@VI1PR0702MB3840.eurprd07.prod.outlook.com>
References: <VI1PR0702MB38408B595C818F1C3278873EE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <VI1PR0702MB3840E7DCBEA62BB204CA863DE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20190216182355.GE23000@mit.edu>
 <VI1PR0702MB38400342893473C16C0C6D70E4620@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <HE1PR0702MB3834CF349C1480194E35CADDE4620@HE1PR0702MB3834.eurprd07.prod.outlook.com>
In-Reply-To: <HE1PR0702MB3834CF349C1480194E35CADDE4620@HE1PR0702MB3834.eurprd07.prod.outlook.com>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR10CA0059.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::36) To VI1PR0702MB3840.eurprd07.prod.outlook.com
 (2603:10a6:803:f::33)
x-incomingtopheadermarker: OriginalChecksum:B59C4A0032E4E57C2425E29EF49F2F801F839FD6015DFCE35B95691BE26B8B44;UpperCasedChecksum:C04A4E3E50F3B7761CB8898289D4E1D71C1712754482521D6B9ABE594CD0AB18;SizeAsReceived:8907;Count:62
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [lLQtqcLCQsj41E1gENT08ML8plbHXm2J]
x-microsoft-original-message-id: <9d440370-fe38-0dec-a917-dfc7bce09327@hotmail.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 62
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:AM5EUR02HT118;
x-ms-traffictypediagnostic: AM5EUR02HT118:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:AM5EUR02HT118;BCL:0;PCL:0;RULEID:;SRVR:AM5EUR02HT118;
x-microsoft-antispam-message-info: duwgg5+dzWLcbzRZ4S0Ov1yHoDkaNSiuWhOfAgBHdZGFoCa+DoiNYlwM9GXRG7eA
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <27E1CDE7DEC63A41A889107B34659020@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d1b590-202e-48f3-808b-08d6951a4773
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2019 20:55:41.6201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading from /dev/random may return data while the getrandom
syscall is still blocking.

Those bytes are not yet cryptographically secure.

The first byte from /dev/random can have as little
as 8 bits entropy estimation.  Once a read blocks, it will
block until /proc/sys/kernel/random/read_wakeup_threshold
bits are available, which is usually 64 bits, but can be
configured as low as 8 bits.  A select will wake up when
at least read_wakeup_threshold bits are available.
Also when constantly reading bytes out of /dev/random
it will prevent the crng init done event forever.

Furthermore previously the input_pool got initialized when
more than 128 bits of raw entropy are accumulated, but that
is only credited 80 bits of pool entroy.  Therefore if
random_write_wakeup_bits is configured lower than 80 bits,
the code path that sends entropy to the blocking_pool can
get activated, before the CRNG is initialized and delays
the initialization of the CRNG until the blocking_pool is
filled to 75%.

Fixed by making read and select on /dev/random wait until
the input_pool is initialized which means that more than
128 bits of entropy have been fed into the input_pool.
This is guaranteed to happen after the CRNG is ready.
So after the first byte is readable from /dev/random
also /dev/urandom is guaranteed to be fully initialized.

Another minor tweak this patch makes, is when the primary
CRNG is periodically reseeded, we reserve twice the amount
of read_wakeup_threshold for fairness reasons, to keep
/dev/random readable when it is not accessed by user mode.

And finally, when the system runs for long times the jiffies
may roll over, but crng_global_init_time is not updated
when reseed every 5 minutes happens.  This could cause
CRNG reseeding all the time, making the input_pool run
low on entropy which would make /dev/random block
unexpectedly.

Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
---
v4 makes the /dev/random block until the input_pool has
reached 128 bits of entropy at least once.  Now make
everything depend on input_pool.initialized.
Additionally fixed a potential issue with jiffies roll
over in the CRNG reseeding logic, which would cause the
cgng_global_init_time to be in the future, causing
reseeding to happen all the time.
Finally added a fairness reserve to keep the /dev/random
in the readable state (select can check non-destructively),
when nothing but CRNG reseeding happens.
---
 drivers/char/random.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index bd449ad..97cde01 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -645,6 +645,7 @@ static void process_random_ready_list(void)
 static void credit_entropy_bits(struct entropy_store *r, int nbits)
 {
 	int entropy_count, orig;
+	int entropy_bits;
 	const int pool_size = r->poolinfo->poolfracbits;
 	int nfrac = nbits << ENTROPY_SHIFT;
 
@@ -702,8 +703,9 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 	if (cmpxchg(&r->entropy_count, orig, entropy_count) != orig)
 		goto retry;
 
+	entropy_bits = entropy_count >> ENTROPY_SHIFT;
 	r->entropy_total += nbits;
-	if (!r->initialized && r->entropy_total > 128) {
+	if (!r->initialized && entropy_bits >= 128) {
 		r->initialized = 1;
 		r->entropy_total = 0;
 	}
@@ -713,8 +715,6 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 				  r->entropy_total, _RET_IP_);
 
 	if (r == &input_pool) {
-		int entropy_bits = entropy_count >> ENTROPY_SHIFT;
-
 		if (crng_init < 2 && entropy_bits >= 128) {
 			crng_reseed(&primary_crng, r);
 			entropy_bits = r->entropy_count >> ENTROPY_SHIFT;
@@ -722,10 +722,12 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 
 		/* should we wake readers? */
 		if (entropy_bits >= random_read_wakeup_bits &&
+		    r->initialized &&
 		    wq_has_sleeper(&random_read_wait)) {
 			wake_up_interruptible(&random_read_wait);
 			kill_fasync(&fasync, SIGIO, POLL_IN);
 		}
+
 		/* If the input pool is getting full, send some
 		 * entropy to the blocking pool until it is 75% full.
 		 */
@@ -917,9 +919,11 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
 	} buf;
 
 	if (r) {
-		num = extract_entropy(r, &buf, 32, 16, 0);
+		num = extract_entropy(r, &buf, 32, 16, crng_ready()
+				      ? random_read_wakeup_bits / 4 : 0);
 		if (num == 0)
 			return;
+		crng_global_init_time = jiffies;
 	} else {
 		_extract_crng(&primary_crng, buf.block);
 		_crng_backtrack_protect(&primary_crng, buf.block,
@@ -1652,7 +1656,7 @@ EXPORT_SYMBOL(get_random_bytes);
  */
 int wait_for_random_bytes(void)
 {
-	if (likely(crng_ready()))
+	if (crng_ready())
 		return 0;
 	return wait_event_interruptible(crng_init_wait, crng_ready());
 }
@@ -1826,7 +1830,9 @@ _random_read(int nonblock, char __user *buf, size_t nbytes)
 
 	nbytes = min_t(size_t, nbytes, SEC_XFER_SIZE);
 	while (1) {
-		n = extract_entropy_user(&blocking_pool, buf, nbytes);
+		n = input_pool.initialized
+			? extract_entropy_user(&blocking_pool, buf, nbytes)
+			: 0;
 		if (n < 0)
 			return n;
 		trace_random_read(n*8, (nbytes-n)*8,
@@ -1840,6 +1846,7 @@ _random_read(int nonblock, char __user *buf, size_t nbytes)
 			return -EAGAIN;
 
 		wait_event_interruptible(random_read_wait,
+			input_pool.initialized &&
 			ENTROPY_BITS(&input_pool) >=
 			random_read_wakeup_bits);
 		if (signal_pending(current))
@@ -1884,7 +1891,8 @@ random_poll(struct file *file, poll_table * wait)
 	poll_wait(file, &random_read_wait, wait);
 	poll_wait(file, &random_write_wait, wait);
 	mask = 0;
-	if (ENTROPY_BITS(&input_pool) >= random_read_wakeup_bits)
+	if (input_pool.initialized &&
+		ENTROPY_BITS(&input_pool) >= random_read_wakeup_bits)
 		mask |= EPOLLIN | EPOLLRDNORM;
 	if (ENTROPY_BITS(&input_pool) < random_write_wakeup_bits)
 		mask |= EPOLLOUT | EPOLLWRNORM;
-- 
2.7.4
