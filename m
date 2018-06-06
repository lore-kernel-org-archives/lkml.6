Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 968F9601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932552AbeFFI0E convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Wed, 6 Jun 2018 04:26:04 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:39108 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932330AbeFFI0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:26:00 -0400
From: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
To: Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] lib/mpi: headers cleanup
Thread-Topic: [PATCH] lib/mpi: headers cleanup
Thread-Index: AQHT+cXBAVxkaj+A3k+H4e5xnjYqzqRS6yAE
Date: Wed, 6 Jun 2018 08:25:55 +0000
Message-ID: <C2D7A727C393B644B70DF4B4DCFB60B921E34DDC@FRAEML521-MBX.china.huawei.com>
References: <fb2fc1ef-1185-f0a3-d8d0-173d2f97bbaf@virtuozzo.com>
In-Reply-To: <fb2fc1ef-1185-f0a3-d8d0-173d2f97bbaf@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.122.225.32]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks goo, you also updated comments of location of some functions.

Acked-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>

Thanks
________________________________________
From: Vasily Averin [vvs@virtuozzo.com]
Sent: Friday, June 01, 2018 7:29 PM
To: Andrew Morton; linux-kernel@vger.kernel.org
Cc: Dmitry Kasatkin
Subject: [PATCH] lib/mpi: headers cleanup

MPI headers contain definitions for huge number of non-existing functions.
Most part of these functions was removed in 2012 by Dmitry Kasatkin
commit 7cf4206a99d1 ("Remove unused code from MPI library")
commit 9e235dcaf4f6 ("Revert "crypto: GnuPG based MPI lib - additional ...")
commit bc95eeadf5c6 ("lib/mpi: removed unused functions")
however headers was not updated properly.

Also I deleted some unused macros.

cc: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 include/linux/mpi.h    | 61 ----------------------------------------
 lib/mpi/mpi-internal.h | 75 ++++----------------------------------------------
 2 files changed, 5 insertions(+), 131 deletions(-)

diff --git a/include/linux/mpi.h b/include/linux/mpi.h
index 1cc5ffb..7cd1473 100644
--- a/include/linux/mpi.h
+++ b/include/linux/mpi.h
@@ -53,93 +53,32 @@ struct gcry_mpi {
 typedef struct gcry_mpi *MPI;

 #define mpi_get_nlimbs(a)     ((a)->nlimbs)
-#define mpi_is_neg(a)        ((a)->sign)

 /*-- mpiutil.c --*/
 MPI mpi_alloc(unsigned nlimbs);
-MPI mpi_alloc_secure(unsigned nlimbs);
-MPI mpi_alloc_like(MPI a);
 void mpi_free(MPI a);
 int mpi_resize(MPI a, unsigned nlimbs);
-int mpi_copy(MPI *copy, const MPI a);
-void mpi_clear(MPI a);
-int mpi_set(MPI w, MPI u);
-int mpi_set_ui(MPI w, ulong u);
-MPI mpi_alloc_set_ui(unsigned long u);
-void mpi_m_check(MPI a);
-void mpi_swap(MPI a, MPI b);

 /*-- mpicoder.c --*/
-MPI do_encode_md(const void *sha_buffer, unsigned nbits);
 MPI mpi_read_raw_data(const void *xbuffer, size_t nbytes);
 MPI mpi_read_from_buffer(const void *buffer, unsigned *ret_nread);
 MPI mpi_read_raw_from_sgl(struct scatterlist *sgl, unsigned int len);
-int mpi_fromstr(MPI val, const char *str);
-u32 mpi_get_keyid(MPI a, u32 *keyid);
 void *mpi_get_buffer(MPI a, unsigned *nbytes, int *sign);
 int mpi_read_buffer(MPI a, uint8_t *buf, unsigned buf_len, unsigned *nbytes,
                    int *sign);
-void *mpi_get_secure_buffer(MPI a, unsigned *nbytes, int *sign);
 int mpi_write_to_sgl(MPI a, struct scatterlist *sg, unsigned nbytes,
                     int *sign);

-#define log_mpidump g10_log_mpidump
-
-/*-- mpi-add.c --*/
-int mpi_add_ui(MPI w, MPI u, ulong v);
-int mpi_add(MPI w, MPI u, MPI v);
-int mpi_addm(MPI w, MPI u, MPI v, MPI m);
-int mpi_sub_ui(MPI w, MPI u, ulong v);
-int mpi_sub(MPI w, MPI u, MPI v);
-int mpi_subm(MPI w, MPI u, MPI v, MPI m);
-
-/*-- mpi-mul.c --*/
-int mpi_mul_ui(MPI w, MPI u, ulong v);
-int mpi_mul_2exp(MPI w, MPI u, ulong cnt);
-int mpi_mul(MPI w, MPI u, MPI v);
-int mpi_mulm(MPI w, MPI u, MPI v, MPI m);
-
-/*-- mpi-div.c --*/
-ulong mpi_fdiv_r_ui(MPI rem, MPI dividend, ulong divisor);
-int mpi_fdiv_r(MPI rem, MPI dividend, MPI divisor);
-int mpi_fdiv_q(MPI quot, MPI dividend, MPI divisor);
-int mpi_fdiv_qr(MPI quot, MPI rem, MPI dividend, MPI divisor);
-int mpi_tdiv_r(MPI rem, MPI num, MPI den);
-int mpi_tdiv_qr(MPI quot, MPI rem, MPI num, MPI den);
-int mpi_tdiv_q_2exp(MPI w, MPI u, unsigned count);
-int mpi_divisible_ui(const MPI dividend, ulong divisor);
-
-/*-- mpi-gcd.c --*/
-int mpi_gcd(MPI g, const MPI a, const MPI b);
-
 /*-- mpi-pow.c --*/
-int mpi_pow(MPI w, MPI u, MPI v);
 int mpi_powm(MPI res, MPI base, MPI exp, MPI mod);

-/*-- mpi-mpow.c --*/
-int mpi_mulpowm(MPI res, MPI *basearray, MPI *exparray, MPI mod);
-
 /*-- mpi-cmp.c --*/
 int mpi_cmp_ui(MPI u, ulong v);
 int mpi_cmp(MPI u, MPI v);

-/*-- mpi-scan.c --*/
-int mpi_getbyte(MPI a, unsigned idx);
-void mpi_putbyte(MPI a, unsigned idx, int value);
-unsigned mpi_trailing_zeros(MPI a);
-
 /*-- mpi-bit.c --*/
 void mpi_normalize(MPI a);
 unsigned mpi_get_nbits(MPI a);
-int mpi_test_bit(MPI a, unsigned n);
-int mpi_set_bit(MPI a, unsigned n);
-int mpi_set_highbit(MPI a, unsigned n);
-void mpi_clear_highbit(MPI a, unsigned n);
-void mpi_clear_bit(MPI a, unsigned n);
-int mpi_rshift(MPI x, MPI a, unsigned n);
-
-/*-- mpi-inv.c --*/
-int mpi_invm(MPI x, MPI u, MPI v);

 /* inline functions */

diff --git a/lib/mpi/mpi-internal.h b/lib/mpi/mpi-internal.h
index 7eceedd..c2d6f4e 100644
--- a/lib/mpi/mpi-internal.h
+++ b/lib/mpi/mpi-internal.h
@@ -65,13 +65,6 @@
 typedef mpi_limb_t *mpi_ptr_t; /* pointer to a limb */
 typedef int mpi_size_t;                /* (must be a signed type) */

-static inline int RESIZE_IF_NEEDED(MPI a, unsigned b)
-{
-       if (a->alloced < b)
-               return mpi_resize(a, b);
-       return 0;
-}
-
 /* Copy N limbs from S to D.  */
 #define MPN_COPY(d, s, n) \
        do {                                    \
@@ -80,13 +73,6 @@ static inline int RESIZE_IF_NEEDED(MPI a, unsigned b)
                        (d)[_i] = (s)[_i];      \
        } while (0)

-#define MPN_COPY_INCR(d, s, n) \
-       do {                                    \
-               mpi_size_t _i;                  \
-               for (_i = 0; _i < (n); _i++)    \
-                       (d)[_i] = (s)[_i];      \
-       } while (0)
-
 #define MPN_COPY_DECR(d, s, n) \
        do {                                    \
                mpi_size_t _i;                  \
@@ -111,15 +97,6 @@ static inline int RESIZE_IF_NEEDED(MPI a, unsigned b)
                }                               \
        } while (0)

-#define MPN_NORMALIZE_NOT_ZERO(d, n) \
-       do {                            \
-               for (;;) {              \
-                       if ((d)[(n)-1]) \
-                               break;  \
-                       (n)--;          \
-               }                       \
-       } while (0)
-
 #define MPN_MUL_N_RECURSE(prodp, up, vp, size, tspace) \
        do {                                                    \
                if ((size) < KARATSUBA_THRESHOLD)               \
@@ -128,46 +105,11 @@ static inline int RESIZE_IF_NEEDED(MPI a, unsigned b)
                        mul_n(prodp, up, vp, size, tspace);     \
        } while (0);

-/* Divide the two-limb number in (NH,,NL) by D, with DI being the largest
- * limb not larger than (2**(2*BITS_PER_MP_LIMB))/D - (2**BITS_PER_MP_LIMB).
- * If this would yield overflow, DI should be the largest possible number
- * (i.e., only ones).  For correct operation, the most significant bit of D
- * has to be set.  Put the quotient in Q and the remainder in R.
- */
-#define UDIV_QRNND_PREINV(q, r, nh, nl, d, di) \
-       do {                                                            \
-               mpi_limb_t _q, _ql, _r;                                 \
-               mpi_limb_t _xh, _xl;                                    \
-               umul_ppmm(_q, _ql, (nh), (di));                         \
-               _q += (nh);     /* DI is 2**BITS_PER_MPI_LIMB too small */ \
-               umul_ppmm(_xh, _xl, _q, (d));                           \
-               sub_ddmmss(_xh, _r, (nh), (nl), _xh, _xl);              \
-               if (_xh) {                                              \
-                       sub_ddmmss(_xh, _r, _xh, _r, 0, (d));           \
-                       _q++;                                           \
-                       if (_xh) {                                      \
-                               sub_ddmmss(_xh, _r, _xh, _r, 0, (d));   \
-                               _q++;                                   \
-                       }                                               \
-               }                                                       \
-               if (_r >= (d)) {                                        \
-                       _r -= (d);                                      \
-                       _q++;                                           \
-               }                                                       \
-               (r) = _r;                                               \
-               (q) = _q;                                               \
-       } while (0)
-
 /*-- mpiutil.c --*/
 mpi_ptr_t mpi_alloc_limb_space(unsigned nlimbs);
 void mpi_free_limb_space(mpi_ptr_t a);
 void mpi_assign_limb_space(MPI a, mpi_ptr_t ap, unsigned nlimbs);

-/*-- mpi-bit.c --*/
-void mpi_rshift_limbs(MPI a, unsigned int count);
-int mpi_lshift_limbs(MPI a, unsigned int count);
-
-/*-- mpihelp-add.c --*/
 static inline mpi_limb_t mpihelp_add_1(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
                         mpi_size_t s1_size, mpi_limb_t s2_limb);
 mpi_limb_t mpihelp_add_n(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
@@ -175,7 +117,6 @@ mpi_limb_t mpihelp_add_n(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
 static inline mpi_limb_t mpihelp_add(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr, mpi_size_t s1_size,
                       mpi_ptr_t s2_ptr, mpi_size_t s2_size);

-/*-- mpihelp-sub.c --*/
 static inline mpi_limb_t mpihelp_sub_1(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
                         mpi_size_t s1_size, mpi_limb_t s2_limb);
 mpi_limb_t mpihelp_sub_n(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
@@ -183,10 +124,10 @@ mpi_limb_t mpihelp_sub_n(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
 static inline mpi_limb_t mpihelp_sub(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr, mpi_size_t s1_size,
                       mpi_ptr_t s2_ptr, mpi_size_t s2_size);

-/*-- mpihelp-cmp.c --*/
+/*-- mpih-cmp.c --*/
 int mpihelp_cmp(mpi_ptr_t op1_ptr, mpi_ptr_t op2_ptr, mpi_size_t size);

-/*-- mpihelp-mul.c --*/
+/*-- mpih-mul.c --*/

 struct karatsuba_ctx {
        struct karatsuba_ctx *next;
@@ -202,7 +143,6 @@ mpi_limb_t mpihelp_addmul_1(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
                            mpi_size_t s1_size, mpi_limb_t s2_limb);
 mpi_limb_t mpihelp_submul_1(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
                            mpi_size_t s1_size, mpi_limb_t s2_limb);
-int mpihelp_mul_n(mpi_ptr_t prodp, mpi_ptr_t up, mpi_ptr_t vp, mpi_size_t size);
 int mpihelp_mul(mpi_ptr_t prodp, mpi_ptr_t up, mpi_size_t usize,
                mpi_ptr_t vp, mpi_size_t vsize, mpi_limb_t *_result);
 void mpih_sqr_n_basecase(mpi_ptr_t prodp, mpi_ptr_t up, mpi_size_t size);
@@ -214,21 +154,16 @@ int mpihelp_mul_karatsuba_case(mpi_ptr_t prodp,
                               mpi_ptr_t vp, mpi_size_t vsize,
                               struct karatsuba_ctx *ctx);

-/*-- mpihelp-mul_1.c (or xxx/cpu/ *.S) --*/
+/*-- generic_mpih-mul1.c --*/
 mpi_limb_t mpihelp_mul_1(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
                         mpi_size_t s1_size, mpi_limb_t s2_limb);

-/*-- mpihelp-div.c --*/
-mpi_limb_t mpihelp_mod_1(mpi_ptr_t dividend_ptr, mpi_size_t dividend_size,
-                        mpi_limb_t divisor_limb);
+/*-- mpih-div.c --*/
 mpi_limb_t mpihelp_divrem(mpi_ptr_t qp, mpi_size_t qextra_limbs,
                          mpi_ptr_t np, mpi_size_t nsize,
                          mpi_ptr_t dp, mpi_size_t dsize);
-mpi_limb_t mpihelp_divmod_1(mpi_ptr_t quot_ptr,
-                           mpi_ptr_t dividend_ptr, mpi_size_t dividend_size,
-                           mpi_limb_t divisor_limb);

-/*-- mpihelp-shift.c --*/
+/*-- generic_mpih-[lr]shift.c --*/
 mpi_limb_t mpihelp_lshift(mpi_ptr_t wp, mpi_ptr_t up, mpi_size_t usize,
                          unsigned cnt);
 mpi_limb_t mpihelp_rshift(mpi_ptr_t wp, mpi_ptr_t up, mpi_size_t usize,
--
2.7.4
